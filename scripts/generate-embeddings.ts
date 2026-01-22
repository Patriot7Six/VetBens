import { createClient } from '@supabase/supabase-js';
import { generateEmbeddingsForConditions } from '../lib/utils/embeddings';
import * as dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

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

async function main() {
  console.log('Fetching conditions from database...');
  
  const { data: conditions, error } = await supabase
    .from('conditions')
    .select('id, name, description')
    .is('embedding', null);

  if (error) {
    console.error('Error fetching conditions:', error);
    process.exit(1);
  }

  if (!conditions || conditions.length === 0) {
    console.log('No conditions found without embeddings. All done!');
    return;
  }

  console.log(`Found ${conditions.length} conditions without embeddings`);
  console.log('Generating embeddings...\n');

  const embeddingsData = await generateEmbeddingsForConditions(conditions);

  console.log('\nUpdating database with embeddings...');
  
  let successCount = 0;
  let errorCount = 0;

  for (const { id, embedding } of embeddingsData) {
    const { error: updateError } = await supabase
      .from('conditions')
      .update({ embedding })
      .eq('id', id);

    if (updateError) {
      console.error(`Error updating condition ${id}:`, updateError);
      errorCount++;
    } else {
      successCount++;
    }
  }

  console.log('\n=== Summary ===');
  console.log(`Successfully updated: ${successCount} conditions`);
  console.log(`Errors: ${errorCount} conditions`);
  console.log('Done!');
}

main().catch(console.error);
