-- Enable pgvector extension for vector similarity search
CREATE EXTENSION IF NOT EXISTS vector;

-- Categories table
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Conditions table
CREATE TABLE conditions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  dc_code TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL,
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  rating_percentages INTEGER[] NOT NULL DEFAULT '{}',
  embedding vector(1536),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Secondary relationships table
CREATE TABLE secondary_relationships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  primary_condition_id UUID NOT NULL REFERENCES conditions(id) ON DELETE CASCADE,
  secondary_condition_id UUID NOT NULL REFERENCES conditions(id) ON DELETE CASCADE,
  connection_strength TEXT NOT NULL CHECK (connection_strength IN ('weak', 'moderate', 'strong')),
  potential_rating_range TEXT NOT NULL,
  explanation TEXT NOT NULL,
  evidence_level TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(primary_condition_id, secondary_condition_id)
);

-- VSO Organizations table
CREATE TABLE vso_organizations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  abbreviation TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL,
  website_url TEXT NOT NULL,
  logo_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_conditions_category_id ON conditions(category_id);
CREATE INDEX idx_conditions_dc_code ON conditions(dc_code);
CREATE INDEX idx_conditions_embedding ON conditions USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);
CREATE INDEX idx_secondary_primary ON secondary_relationships(primary_condition_id);
CREATE INDEX idx_secondary_secondary ON secondary_relationships(secondary_condition_id);
CREATE INDEX idx_secondary_strength ON secondary_relationships(connection_strength);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to auto-update updated_at on conditions
CREATE TRIGGER update_conditions_updated_at
  BEFORE UPDATE ON conditions
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Vector search function to find similar conditions
CREATE OR REPLACE FUNCTION match_conditions(
  query_embedding vector(1536),
  match_threshold float DEFAULT 0.5,
  match_count int DEFAULT 10
)
RETURNS TABLE (
  id UUID,
  name TEXT,
  dc_code TEXT,
  description TEXT,
  category_id UUID,
  rating_percentages INTEGER[],
  similarity float
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    conditions.id,
    conditions.name,
    conditions.dc_code,
    conditions.description,
    conditions.category_id,
    conditions.rating_percentages,
    1 - (conditions.embedding <=> query_embedding) AS similarity
  FROM conditions
  WHERE conditions.embedding IS NOT NULL
    AND 1 - (conditions.embedding <=> query_embedding) > match_threshold
  ORDER BY conditions.embedding <=> query_embedding
  LIMIT match_count;
END;
$$;
