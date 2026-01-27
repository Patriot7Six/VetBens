import OpenAI from 'openai';

const EXPECTED_DIMENSIONS = 1536;

let openaiClient: OpenAI | null = null;

function getOpenAIClient(): OpenAI {
  if (!openaiClient) {
    if (!process.env.OPENAI_API_KEY) {
      throw new Error(
        'OPENAI_API_KEY is not set. This utility can only be used server-side.'
      );
    }
    openaiClient = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
  }
  return openaiClient;
}

export async function generateEmbedding(text: string): Promise<number[]> {
  const openai = getOpenAIClient();

  try {
    const response = await openai.embeddings.create({
      model: 'text-embedding-ada-002',
      input: text,
    });

    const embedding = response.data[0].embedding;

    if (embedding.length !== EXPECTED_DIMENSIONS) {
      throw new Error(
        `Expected ${EXPECTED_DIMENSIONS} dimensions, got ${embedding.length}`
      );
    }

    return embedding;
  } catch (error) {
    console.error('Error generating embedding:', error);
    throw error;
  }
}

export async function generateEmbeddingsForConditions(
  conditions: Array<{ id: string; name: string; description: string }>,
  options: { delayMs?: number } = {}
): Promise<Array<{ id: string; embedding: number[] }>> {
  const { delayMs = 100 } = options;
  const results = [];

  for (let i = 0; i < conditions.length; i++) {
    const condition = conditions[i];
    const text = `${condition.name}. ${condition.description}`;
    
    try {
      const embedding = await generateEmbedding(text);
      results.push({
        id: condition.id,
        embedding,
      });
      
      console.log(
        `[${i + 1}/${conditions.length}] Generated embedding for: ${condition.name}`
      );
      
      if (i < conditions.length - 1) {
        await new Promise(resolve => setTimeout(resolve, delayMs));
      }
    } catch (error) {
      console.error(
        `[${i + 1}/${conditions.length}] Failed to generate embedding for ${condition.name}:`,
        error
      );
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
