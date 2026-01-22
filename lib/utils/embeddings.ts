import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export async function generateEmbedding(text: string): Promise<number[]> {
  try {
    const response = await openai.embeddings.create({
      model: 'text-embedding-ada-002',
      input: text,
    });

    return response.data[0].embedding;
  } catch (error) {
    console.error('Error generating embedding:', error);
    throw error;
  }
}

export async function generateEmbeddingsForConditions(
  conditions: Array<{ id: string; name: string; description: string }>
): Promise<Array<{ id: string; embedding: number[] }>> {
  const results = [];

  for (const condition of conditions) {
    const text = `${condition.name}. ${condition.description}`;
    
    try {
      const embedding = await generateEmbedding(text);
      results.push({
        id: condition.id,
        embedding,
      });
      
      console.log(`Generated embedding for: ${condition.name}`);
      
      await new Promise(resolve => setTimeout(resolve, 100));
    } catch (error) {
      console.error(`Failed to generate embedding for ${condition.name}:`, error);
    }
  }

  return results;
}

export function cosineSimilarity(a: number[], b: number[]): number {
  if (a.length !== b.length) {
    throw new Error('Vectors must have the same length');
  }

  let dotProduct = 0;
  let normA = 0;
  let normB = 0;

  for (let i = 0; i < a.length; i++) {
    dotProduct += a[i] * b[i];
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }

  return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
}
