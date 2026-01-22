# Vector Embeddings Scripts

This folder contains scripts for generating and testing vector embeddings for the VetBens Foundation application.

## Prerequisites

Before running these scripts, ensure you have:

1. **Supabase Project Set Up**
   - Run the migrations in `supabase/migrations/001_initial_schema.sql`
   - Seed the database with categories and conditions using `supabase/seed.sql`
   - pgvector extension must be enabled

2. **Environment Variables**
   Update `.env.local` with your credentials:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
   OPENAI_API_KEY=your-openai-api-key
   ```

3. **Dependencies Installed**
   ```bash
   npm install
   ```

## Scripts

### 1. Generate Embeddings

**Command**: `npm run generate-embeddings`

**Purpose**: Generates vector embeddings for all conditions in the database that don't have embeddings yet.

**Process**:
- Fetches all conditions without embeddings from Supabase
- Generates embeddings using OpenAI's `text-embedding-ada-002` model
- Combines condition name and description for rich semantic content
- Updates the database with the generated embeddings
- Includes rate limiting (100ms delay between requests)

**Expected Output**:
```
Fetching conditions from database...
Found 98 conditions without embeddings
Generating embeddings...

Generated embedding for: Lupus (SLE)
Generated embedding for: Rheumatoid Arthritis
...

Updating database with embeddings...

=== Summary ===
Successfully updated: 98 conditions
Errors: 0 conditions
Done!
```

**Cost Estimate**: 
- ~$0.0001 per condition (OpenAI ada-002 pricing)
- For 100 conditions: ~$0.01

**Time Estimate**: 
- ~15-30 seconds for 100 conditions (with rate limiting)

### 2. Test Vector Search

**Command**: `npm run test-vector-search`

**Purpose**: Verifies that vector search is working correctly.

**Tests Performed**:
1. **Similarity Search**: Takes a random condition with an embedding and finds similar conditions
2. **Text Query Search**: Searches for conditions matching a text query ("chronic pain and inflammation in joints")

**Expected Output**:
```
=== Testing Vector Search ===

Test Condition: Lupus (SLE)
Description: Autoimmune disease affecting multiple body systems...

Searching for similar conditions...

Found 5 similar conditions:

1. Lupus (SLE) (DC 6350)
   Similarity: 100.00%
   Description: Autoimmune disease affecting multiple body systems...

2. Rheumatoid Arthritis (DC 5002)
   Similarity: 87.34%
   Description: Chronic inflammatory disorder affecting joints...

...

=== Vector Search Test Completed Successfully ===
Average similarity: 82.45%
Performance: 5 results returned

=== Testing Search by Text Query ===

Query: "chronic pain and inflammation in joints"

...

✅ All tests passed!
```

## Troubleshooting

### Error: "No conditions found without embeddings"
- This means all conditions already have embeddings
- Re-run the seed script if you want to add new conditions

### Error: "Missing Supabase credentials"
- Check that `.env.local` has the correct `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY`

### Error: "Missing OpenAI API key"
- Add `OPENAI_API_KEY` to `.env.local`
- Get an API key from https://platform.openai.com/api-keys

### Error: "pgvector extension not found"
- Run the migration file that includes `CREATE EXTENSION IF NOT EXISTS vector;`
- Ensure your Supabase project supports pgvector

### Slow embedding generation
- The script includes a 100ms delay between requests to avoid rate limits
- For large datasets (500+ conditions), consider batch processing or Supabase Edge Functions

## Performance Optimization

For production deployments with large datasets:

1. **Use Supabase Edge Functions**: Generate embeddings server-side to avoid API rate limits
2. **Batch Processing**: Process embeddings in batches of 100
3. **Caching**: Cache embeddings to avoid regenerating for unchanged conditions
4. **Index Tuning**: Adjust the ivfflat index parameters based on dataset size

## Next Steps

After running these scripts successfully:

1. Verify embeddings in Supabase dashboard
2. Test the `/api/secondary` endpoint which uses vector search
3. Implement the secondary condition discovery UI
4. Monitor search performance and adjust thresholds
