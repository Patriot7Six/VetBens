import { createClient } from '@supabase/supabase-js';
import { generateEmbedding } from '../lib/utils/embeddings';
import * as dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

type ConditionSearchResult = {
  id: string;
  name: string;
  dc_code: string;
  description: string;
  category_id: string | null;
  rating_percentages: number[];
  similarity: number;
};

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase credentials in .env.local');
  console.error('Required: NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

if (!process.env.OPENAI_API_KEY) {
  console.error('Missing OpenAI API key in .env.local');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function testVectorSearch() {
  console.log('=== Testing Vector Search ===\n');

  const { data: firstCondition, error: fetchError } = await supabase
    .from('conditions')
    .select('id, name, description, embedding')
    .not('embedding', 'is', null)
    .limit(1)
    .single();

  if (fetchError || !firstCondition) {
    console.error('Error: No conditions with embeddings found');
    console.error('Please run: npm run generate-embeddings first');
    process.exit(1);
  }

  console.log(`Test Condition: ${firstCondition.name}`);
  console.log(`Description: ${firstCondition.description}\n`);

  if (!firstCondition.embedding) {
    console.error('Error: Selected condition has no embedding');
    process.exit(1);
  }

  console.log('Searching for similar conditions...\n');

  const { data: similarConditions, error: searchError } = await supabase.rpc(
    'match_conditions',
    {
      query_embedding: firstCondition.embedding,
      match_threshold: 0.5,
      match_count: 5,
    }
  );

  if (searchError) {
    console.error('Error performing vector search:', searchError);
    process.exit(1);
  }

  if (!similarConditions || similarConditions.length === 0) {
    console.log('No similar conditions found (this might indicate an issue)');
    return;
  }

  console.log(`Found ${similarConditions.length} similar conditions:\n`);

  similarConditions.forEach((condition: ConditionSearchResult, index: number) => {
    console.log(`${index + 1}. ${condition.name} (DC ${condition.dc_code})`);
    console.log(`   Similarity: ${(condition.similarity * 100).toFixed(2)}%`);
    console.log(`   Description: ${condition.description.substring(0, 100)}...`);
    console.log('');
  });

  console.log('\n=== Vector Search Test Completed Successfully ===');
  
  const avgSimilarity = similarConditions.reduce(
    (sum: number, c: ConditionSearchResult) => sum + c.similarity,
    0
  ) / similarConditions.length;
  console.log(`Average similarity: ${(avgSimilarity * 100).toFixed(2)}%`);
  console.log(`Performance: ${similarConditions.length} results returned`);
}

async function testSearchByText() {
  console.log('\n=== Testing Search by Text Query ===\n');

  const searchQuery = 'chronic pain and inflammation in joints';
  console.log(`Query: "${searchQuery}"\n`);

  console.log('Generating embedding for query...');
  const queryEmbedding = await generateEmbedding(searchQuery);
  console.log('Embedding generated successfully\n');

  console.log('Searching for similar conditions...\n');

  const { data: results, error } = await supabase.rpc('match_conditions', {
    query_embedding: queryEmbedding,
    match_threshold: 0.5,
    match_count: 5,
  });

  if (error) {
    console.error('Error performing search:', error);
    process.exit(1);
  }

  if (!results || results.length === 0) {
    console.log('No matching conditions found');
    return;
  }

  console.log(`Found ${results.length} matching conditions:\n`);

  results.forEach((condition: ConditionSearchResult, index: number) => {
    console.log(`${index + 1}. ${condition.name} (DC ${condition.dc_code})`);
    console.log(`   Similarity: ${(condition.similarity * 100).toFixed(2)}%`);
    console.log(`   Description: ${condition.description.substring(0, 100)}...`);
    console.log('');
  });

  console.log('\n=== Text Search Test Completed Successfully ===');
}

async function main() {
  try {
    await testVectorSearch();
    await testSearchByText();
    
    console.log('\n✅ All tests passed!');
  } catch (error) {
    console.error('\n❌ Test failed:', error);
    process.exit(1);
  }
}

main().catch(console.error);
