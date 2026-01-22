# Vector Embeddings Setup Guide

This guide explains how to set up and use vector embeddings for the VetBens Foundation application.

## Overview

Vector embeddings enable semantic search for medical conditions, allowing the application to:
- Find similar conditions based on meaning, not just keywords
- Discover potential secondary conditions related to a primary condition
- Provide intelligent condition suggestions

## What Was Implemented

### 1. Embeddings Utility (`lib/utils/embeddings.ts`)

A utility module that provides:
- `generateEmbedding(text)`: Generates a 1536-dimensional embedding for a given text using OpenAI's ada-002 model
- `generateEmbeddingsForConditions(conditions)`: Batch generates embeddings for multiple conditions
- `cosineSimilarity(a, b)`: Calculates cosine similarity between two vectors (for client-side comparisons)

### 2. Embedding Generation Script (`scripts/generate-embeddings.ts`)

A standalone script that:
- Connects to Supabase and fetches all conditions without embeddings
- Generates embeddings by combining condition name + description
- Updates the database with the generated embeddings
- Includes error handling and progress reporting
- Uses rate limiting (100ms delay) to avoid API limits

**Usage**: `npm run generate-embeddings`

### 3. Vector Search Test Script (`scripts/test-vector-search.ts`)

A comprehensive test suite that:
- Tests vector similarity search using an existing condition
- Tests text query search using a natural language query
- Validates the Supabase `match_conditions` function
- Reports similarity scores and performance metrics

**Usage**: `npm run test-vector-search`

## Setup Instructions

### Step 1: Configure Environment Variables

Add your OpenAI API key to `.env.local`:

```env
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
OPENAI_API_KEY=sk-your-openai-api-key-here
```

Get an OpenAI API key from: https://platform.openai.com/api-keys

### Step 2: Ensure Database is Set Up

Make sure you have:
1. ✅ Run the migration: `supabase/migrations/001_initial_schema.sql`
2. ✅ Seeded categories and conditions: `supabase/seed.sql`
3. ✅ pgvector extension enabled
4. ✅ Vector index created on `conditions.embedding`

### Step 3: Generate Embeddings

Run the embedding generation script:

```bash
npm run generate-embeddings
```

This will:
- Process all conditions in the database
- Generate embeddings (takes ~15-30 seconds for 100 conditions)
- Cost: ~$0.01 for 100 conditions (OpenAI pricing)

**Expected Output**:
```
Fetching conditions from database...
Found 98 conditions without embeddings
Generating embeddings...

Generated embedding for: Lupus (SLE)
Generated embedding for: Rheumatoid Arthritis
Generated embedding for: PTSD
...

Updating database with embeddings...

=== Summary ===
Successfully updated: 98 conditions
Errors: 0 conditions
Done!
```

### Step 4: Verify Vector Search

Test that vector search is working correctly:

```bash
npm run test-vector-search
```

**Expected Output**:
```
=== Testing Vector Search ===

Test Condition: Lupus (SLE)
Description: Autoimmune disease affecting multiple body systems...

Found 5 similar conditions:

1. Lupus (SLE) (DC 6350) - Similarity: 100.00%
2. Rheumatoid Arthritis (DC 5002) - Similarity: 87.34%
...

=== Testing Search by Text Query ===

Query: "chronic pain and inflammation in joints"

Found 5 matching conditions:
...

✅ All tests passed!
```

## How Vector Search Works

### 1. Embedding Generation

When you run `npm run generate-embeddings`:

```typescript
// Combines name and description for semantic richness
const text = `${condition.name}. ${condition.description}`;

// Generates 1536-dimensional vector
const embedding = await generateEmbedding(text);

// Stores in database
await supabase
  .from('conditions')
  .update({ embedding })
  .eq('id', condition.id);
```

### 2. Vector Search Function

The database function `match_conditions` uses cosine distance:

```sql
SELECT
  conditions.id,
  conditions.name,
  conditions.dc_code,
  1 - (conditions.embedding <=> query_embedding) AS similarity
FROM conditions
WHERE conditions.embedding IS NOT NULL
  AND 1 - (conditions.embedding <=> query_embedding) > match_threshold
ORDER BY conditions.embedding <=> query_embedding
LIMIT match_count;
```

**Operators**:
- `<=>` is the cosine distance operator from pgvector
- `1 - distance` converts to similarity (0-1 range)
- Higher similarity = more similar conditions

### 3. Using Vector Search in API Routes

Example usage in `/api/secondary/route.ts`:

```typescript
import { generateEmbedding } from '@/lib/utils/embeddings';

// Get embedding for a condition
const { data: primaryCondition } = await supabase
  .from('conditions')
  .select('embedding')
  .eq('id', conditionId)
  .single();

// Find similar conditions
const { data: similarConditions } = await supabase.rpc('match_conditions', {
  query_embedding: primaryCondition.embedding,
  match_threshold: 0.7, // 70% similarity minimum
  match_count: 10, // Return top 10
});
```

## Performance Considerations

### Embedding Generation
- **Time**: ~200ms per condition (including rate limiting)
- **Cost**: $0.0001 per condition (OpenAI ada-002)
- **One-time**: Only needed when adding new conditions

### Vector Search
- **Query Time**: < 100ms for database with 500 conditions
- **Scalability**: ivfflat index provides sub-linear performance
- **Cost**: Free (runs in Supabase)

### Index Tuning

For large datasets (1000+ conditions), tune the ivfflat index:

```sql
-- Adjust 'lists' parameter based on dataset size
-- Rule of thumb: lists = sqrt(number_of_rows)
CREATE INDEX idx_conditions_embedding 
ON conditions 
USING ivfflat (embedding vector_cosine_ops) 
WITH (lists = 100);
```

## Integration with Application

### Secondary Condition Discovery

The vector search is used in the secondary condition discovery feature:

1. User selects primary conditions
2. API generates embeddings for selected conditions
3. Vector search finds semantically similar conditions
4. Results are combined with manually curated relationships
5. UI displays secondary conditions ranked by relevance

### Search Autocomplete

Vector search can enhance the search bar:

```typescript
// User types: "joint pain"
const queryEmbedding = await generateEmbedding("joint pain");

// Find matching conditions
const results = await supabase.rpc('match_conditions', {
  query_embedding: queryEmbedding,
  match_threshold: 0.6,
  match_count: 5,
});
```

## Troubleshooting

### "No conditions found without embeddings"
All conditions already have embeddings. This is normal after the first run.

### "Error generating embedding: 401"
OpenAI API key is invalid or missing. Check `.env.local`.

### "Error generating embedding: 429"
Rate limit exceeded. The script includes built-in rate limiting, but you may need to increase delays.

### Slow search performance
- Check that the ivfflat index exists
- Ensure pgvector extension is properly installed
- Consider adjusting the `lists` parameter for larger datasets

### Low similarity scores
- Condition descriptions may need improvement
- Try lowering `match_threshold` (e.g., 0.5 instead of 0.7)
- Verify embeddings were generated correctly

## Next Steps

Now that vector embeddings are set up:

1. ✅ Embeddings utility created
2. ✅ Generation script working
3. ✅ Vector search function verified
4. ⏭️ Implement `/api/secondary` route using vector search
5. ⏭️ Build secondary conditions UI component
6. ⏭️ Add search autocomplete using embeddings

## Resources

- [OpenAI Embeddings Guide](https://platform.openai.com/docs/guides/embeddings)
- [pgvector Documentation](https://github.com/pgvector/pgvector)
- [Supabase Vector Search](https://supabase.com/docs/guides/ai/vector-embeddings)
