# Technical Specification: VetBens Foundation

## Difficulty Assessment
**Level: HARD**

This is a complex, production-grade application requiring:
- Advanced data modeling with vector embeddings for intelligent condition matching
- Integration with Supabase pgvector for semantic search
- Modern bleeding-edge stack (Next.js 16.1.1, React 19, Tailwind 4.0)
- Complex UI with multi-category filtering, search, and dynamic results
- Secondary condition discovery algorithm
- Print/share functionality

---

## 1. Technical Context

### Technology Stack
- **Frontend Framework**: Next.js 16.1.1 (App Router)
- **UI Library**: React 19
- **Language**: TypeScript 5.7.2
- **Styling**: Tailwind CSS 4.0
- **Backend/Database**: Supabase (PostgreSQL 15+ with pgvector extension)
- **Deployment**: Vercel
- **Additional Libraries**:
  - `@supabase/supabase-js` - Supabase client
  - `@supabase/ssr` - Server-side rendering support
  - `openai` - For generating embeddings (optional, can use Supabase edge functions)
  - `react-icons` - Icon library
  - `framer-motion` - Animations (optional)

### Key Features (Based on Reference Site)
1. **Hero Section**: Value proposition for discovering secondary conditions
2. **Feature Cards**: 321 Conditions, Increase Rating, Documentation
3. **Condition Search**: Search bar with autocomplete
4. **Category Filtering**: Multiple categories (Autoimmune, Cardiovascular, Neurological, etc.)
5. **Condition Selection**: Checkbox-based multi-select with DC codes and rating percentages
6. **Secondary Condition Discovery**: Shows potential secondary conditions based on selections
7. **VSO Assistance**: Links to veteran service organizations
8. **Print/Share**: Export results functionality

---

## 2. Architecture Overview

### Application Structure
```
vetbens/
├── app/
│   ├── layout.tsx                 # Root layout
│   ├── page.tsx                   # Home page (main interface)
│   ├── globals.css                # Tailwind imports
│   ├── api/
│   │   ├── conditions/route.ts    # GET conditions with search/filters
│   │   └── secondary/route.ts     # POST get secondary conditions
│   └── fonts/                     # Custom fonts if needed
├── components/
│   ├── layout/
│   │   ├── Header.tsx             # Logo and navigation
│   │   └── Footer.tsx             # Footer links
│   ├── home/
│   │   ├── Hero.tsx               # Hero section
│   │   ├── FeatureCards.tsx       # 3 feature cards
│   │   ├── ConditionSelector.tsx  # Main condition selection UI
│   │   ├── SearchBar.tsx          # Search input with autocomplete
│   │   ├── CategoryFilter.tsx     # Category chips/buttons
│   │   ├── ConditionList.tsx      # List of conditions with checkboxes
│   │   ├── ConditionCard.tsx      # Individual condition item
│   │   ├── SecondaryResults.tsx   # Results panel showing secondary conditions
│   │   ├── VSOAssistance.tsx      # VSO organizations section
│   │   └── ActionsBar.tsx         # Print/Share buttons
│   └── ui/
│       ├── Button.tsx             # Reusable button component
│       ├── Card.tsx               # Reusable card component
│       └── Badge.tsx              # Badge for ratings, DC codes
├── lib/
│   ├── supabase/
│   │   ├── client.ts              # Browser Supabase client
│   │   ├── server.ts              # Server Supabase client
│   │   └── types.ts               # TypeScript types from DB
│   ├── utils/
│   │   ├── cn.ts                  # className utility
│   │   └── embeddings.ts          # Vector embedding utilities
│   └── constants/
│       ├── categories.ts          # Category definitions
│       └── vso.ts                 # VSO organization data
├── types/
│   └── index.ts                   # Shared TypeScript types
├── supabase/
│   ├── migrations/
│   │   └── 001_initial_schema.sql # Initial database schema
│   └── seed.sql                   # Seed data for conditions
├── public/
│   ├── logo.svg                   # Patriot7Six logo
│   └── icons/                     # Various icons
├── .env.local                     # Environment variables
├── next.config.ts                 # Next.js configuration
├── tailwind.config.ts             # Tailwind CSS configuration
├── tsconfig.json                  # TypeScript configuration
└── package.json                   # Dependencies
```

---

## 3. Data Model

### Database Schema (PostgreSQL with pgvector)

#### Table: `categories`
```sql
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### Table: `conditions`
```sql
CREATE TABLE conditions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  dc_code TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL,
  category_id UUID REFERENCES categories(id),
  rating_percentages INTEGER[] NOT NULL, -- e.g., [10, 20, 30, 50, 70]
  embedding VECTOR(1536), -- OpenAI ada-002 embeddings
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_conditions_embedding ON conditions USING ivfflat (embedding vector_cosine_ops);
CREATE INDEX idx_conditions_category ON conditions(category_id);
CREATE INDEX idx_conditions_dc_code ON conditions(dc_code);
```

#### Table: `secondary_relationships`
```sql
CREATE TABLE secondary_relationships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  primary_condition_id UUID REFERENCES conditions(id) ON DELETE CASCADE,
  secondary_condition_id UUID REFERENCES conditions(id) ON DELETE CASCADE,
  connection_strength TEXT CHECK (connection_strength IN ('weak', 'moderate', 'strong')),
  potential_rating_range TEXT, -- e.g., "10-20%" or "30-50%"
  explanation TEXT NOT NULL,
  evidence_level TEXT, -- Research-based, Clinical, etc.
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(primary_condition_id, secondary_condition_id)
);

CREATE INDEX idx_secondary_primary ON secondary_relationships(primary_condition_id);
CREATE INDEX idx_secondary_secondary ON secondary_relationships(secondary_condition_id);
```

#### Table: `vso_organizations`
```sql
CREATE TABLE vso_organizations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  abbreviation TEXT NOT NULL,
  description TEXT NOT NULL,
  website_url TEXT NOT NULL,
  logo_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### TypeScript Types

```typescript
// types/index.ts
export interface Category {
  id: string;
  name: string;
  slug: string;
  description?: string;
}

export interface Condition {
  id: string;
  name: string;
  dc_code: string;
  description: string;
  category_id: string;
  rating_percentages: number[];
  category?: Category;
}

export interface SecondaryRelationship {
  id: string;
  primary_condition_id: string;
  secondary_condition_id: string;
  connection_strength: 'weak' | 'moderate' | 'strong';
  potential_rating_range: string;
  explanation: string;
  evidence_level?: string;
  secondary_condition?: Condition;
}

export interface VSOOrganization {
  id: string;
  name: string;
  abbreviation: string;
  description: string;
  website_url: string;
  logo_url?: string;
}

export interface SecondaryResult {
  condition: Condition;
  connection_strength: 'weak' | 'moderate' | 'strong';
  potential_rating_range: string;
  explanation: string;
}
```

---

## 4. API Design

### GET `/api/conditions`
**Purpose**: Fetch conditions with optional filtering and search

**Query Parameters**:
- `search?: string` - Search term for condition name or DC code
- `category?: string` - Category slug to filter by
- `limit?: number` - Max results (default: 100)
- `offset?: number` - Pagination offset

**Response**:
```json
{
  "conditions": [
    {
      "id": "uuid",
      "name": "Lupus (SLE)",
      "dc_code": "DC 6350",
      "description": "Autoimmune disease affecting multiple body systems...",
      "category": {
        "id": "uuid",
        "name": "Autoimmune",
        "slug": "autoimmune"
      },
      "rating_percentages": [10, 40, 60, 100]
    }
  ],
  "total": 321
}
```

### POST `/api/secondary`
**Purpose**: Get secondary conditions based on selected primary conditions

**Request Body**:
```json
{
  "condition_ids": ["uuid1", "uuid2"],
  "use_vector_search": true
}
```

**Response**:
```json
{
  "secondary_conditions": [
    {
      "condition": {
        "id": "uuid",
        "name": "Insomnia",
        "dc_code": "DC 9499-9434",
        "description": "Chronic sleep disorder...",
        "rating_percentages": [10, 20, 30, 50, 70]
      },
      "connection_strength": "moderate",
      "potential_rating_range": "10-20%",
      "explanation": "Potential: 10-20% for cervical strain",
      "primary_conditions": ["Carpal Tunnel Syndrome - Right"]
    }
  ]
}
```

---

## 5. Component Design

### Key Components

#### `ConditionSelector.tsx`
Main component that orchestrates the condition selection experience.

**State**:
- `selectedCategory: string | null`
- `searchQuery: string`
- `selectedConditions: Set<string>` (condition IDs)
- `conditions: Condition[]`
- `secondaryResults: SecondaryResult[]`

**Features**:
- Integrates SearchBar, CategoryFilter, ConditionList
- Fetches conditions based on filters
- Triggers secondary condition discovery when selections change

#### `SearchBar.tsx`
Search input with autocomplete/suggestions.

**Props**:
- `value: string`
- `onChange: (value: string) => void`
- `placeholder?: string`

**Features**:
- Debounced search (300ms)
- Shows recent searches
- Highlights matching text in suggestions

#### `CategoryFilter.tsx`
Category pills/chips for filtering.

**Props**:
- `categories: Category[]`
- `selectedCategory: string | null`
- `onSelect: (slug: string | null) => void`

**Features**:
- "All Categories" option
- Active state styling
- Horizontal scrollable on mobile

#### `ConditionCard.tsx`
Individual condition item with checkbox.

**Props**:
- `condition: Condition`
- `selected: boolean`
- `onToggle: (id: string) => void`

**Features**:
- Checkbox for selection
- Display name, DC code, description
- Rating percentage badges
- Hover effects

#### `SecondaryResults.tsx`
Results panel showing discovered secondary conditions.

**Props**:
- `results: SecondaryResult[]`
- `onPrint: () => void`
- `onShare: () => void`

**Features**:
- Grouped by connection strength
- Expandable details
- Connection strength badges (color-coded)
- Explanation text

---

## 6. Vector Search Strategy

### Embedding Generation
1. **Initial Setup**: Generate embeddings for all conditions using OpenAI's `text-embedding-ada-002` model
2. **Embedding Content**: Combine condition name + description for semantic richness
3. **Storage**: Store in `conditions.embedding` column (1536 dimensions)

### Search Implementation
```typescript
// Semantic search function
async function findSimilarConditions(conditionId: string, limit: number = 5) {
  const supabase = createClient();
  
  // Get the embedding of the primary condition
  const { data: primaryCondition } = await supabase
    .from('conditions')
    .select('embedding')
    .eq('id', conditionId)
    .single();
  
  // Find similar conditions using vector similarity
  const { data: similar } = await supabase.rpc('match_conditions', {
    query_embedding: primaryCondition.embedding,
    match_threshold: 0.7,
    match_count: limit
  });
  
  return similar;
}
```

### SQL Function for Vector Search
```sql
CREATE OR REPLACE FUNCTION match_conditions(
  query_embedding VECTOR(1536),
  match_threshold FLOAT,
  match_count INT
)
RETURNS TABLE (
  id UUID,
  name TEXT,
  similarity FLOAT
)
LANGUAGE SQL STABLE
AS $$
  SELECT
    id,
    name,
    1 - (embedding <=> query_embedding) AS similarity
  FROM conditions
  WHERE 1 - (embedding <=> query_embedding) > match_threshold
  ORDER BY similarity DESC
  LIMIT match_count;
$$;
```

---

## 7. Implementation Approach

### Phase 1: Project Setup & Infrastructure
1. Initialize Next.js 16.1.1 project with TypeScript
2. Install and configure Tailwind CSS 4.0
3. Set up Supabase project and configure environment variables
4. Create database schema and enable pgvector extension
5. Set up Supabase client utilities (browser + server)
6. Configure project structure (folders, base files)

### Phase 2: Database & Data
1. Create migration files for all tables
2. Seed categories data (13+ categories from reference)
3. Seed initial conditions data (start with 50-100 conditions)
4. Generate embeddings for conditions
5. Seed secondary relationships (manually curated initially)
6. Seed VSO organizations data

### Phase 3: Core UI Components
1. Build reusable UI components (Button, Card, Badge)
2. Create layout components (Header, Footer)
3. Implement Hero section
4. Implement FeatureCards component
5. Build SearchBar with autocomplete
6. Build CategoryFilter component
7. Build ConditionCard component
8. Build ConditionList component

### Phase 4: Main Features
1. Implement ConditionSelector orchestration
2. Create `/api/conditions` endpoint with search/filter logic
3. Integrate condition fetching with UI
4. Implement multi-select functionality
5. Create `/api/secondary` endpoint
6. Implement secondary condition discovery algorithm
7. Build SecondaryResults component
8. Integrate results display

### Phase 5: Additional Features
1. Implement VSOAssistance section
2. Build print functionality
3. Build share functionality (copy link, social share)
4. Add loading states and skeletons
5. Add error boundaries and error states
6. Implement responsive design refinements
7. Add animations and transitions

### Phase 6: Testing & Deployment
1. Manual testing of all user flows
2. Test responsiveness across devices
3. Test edge cases (no results, errors, etc.)
4. Performance optimization (lazy loading, code splitting)
5. SEO optimization (metadata, Open Graph tags)
6. Deploy to Vercel
7. Configure environment variables in Vercel
8. Test production deployment

---

## 8. Verification Approach

### Testing Strategy
1. **Manual Testing**: Test all user interactions in development
2. **Responsive Testing**: Verify on mobile, tablet, desktop viewports
3. **Browser Testing**: Test on Chrome, Firefox, Safari
4. **Data Validation**: Ensure condition data is accurate and complete
5. **API Testing**: Use Postman or curl to test API endpoints
6. **Edge Cases**: Test search with no results, empty selections, etc.

### Build & Lint Commands
```bash
# Development
npm run dev

# Type checking
npx tsc --noEmit

# Build
npm run build

# Preview production build
npm run start

# Lint (if ESLint is configured)
npm run lint
```

### Success Criteria
- [ ] Application loads without errors
- [ ] All 321+ conditions are searchable and filterable
- [ ] Category filtering works correctly
- [ ] Selecting conditions triggers secondary condition discovery
- [ ] Results are displayed with connection strength and explanations
- [ ] Print functionality works
- [ ] Share functionality works
- [ ] Responsive design works on all screen sizes
- [ ] Site is deployed to Vercel and accessible
- [ ] No TypeScript errors
- [ ] No console errors in production

---

## 9. Environment Variables

```env
# .env.local
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# Optional: For embedding generation
OPENAI_API_KEY=your-openai-key
```

---

## 10. Design System (Tailwind Config)

### Color Palette (Based on Reference Site)
```javascript
// tailwind.config.ts
{
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          // ... navy/dark blue palette
          900: '#0c1e2e', // Dark navy
        },
        accent: {
          DEFAULT: '#f59e0b', // Orange/amber
          light: '#fbbf24',
          dark: '#d97706',
        },
        success: '#10b981',
        warning: '#f59e0b',
        error: '#ef4444',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
}
```

---

## 11. Key Challenges & Considerations

### Challenges
1. **Data Curation**: Manually curating 321+ conditions with accurate DC codes and relationships
2. **Vector Search Accuracy**: Ensuring embeddings produce relevant secondary condition suggestions
3. **Performance**: Handling large datasets efficiently (pagination, virtualization)
4. **Mobile UX**: Complex multi-select interface on small screens
5. **Bleeding-Edge Stack**: Next.js 16.1.1 and React 19 may have breaking changes

### Solutions
1. **Incremental Data**: Start with core conditions, expand iteratively
2. **Hybrid Approach**: Combine manual relationships + vector search
3. **Optimizations**: Use React Server Components, streaming, pagination
4. **Mobile-First**: Design mobile experience first, enhance for desktop
5. **Stay Updated**: Monitor Next.js/React docs for updates and migrations

---

## 12. Future Enhancements (Post-MVP)

- User accounts and saved searches
- Export to PDF with detailed documentation
- Integration with VA.gov APIs
- Community contributions (crowdsourced condition relationships)
- AI chatbot for guided assistance
- Analytics dashboard for admin
- Multi-language support
- Accessibility improvements (WCAG 2.1 AA compliance)

---

## Summary

This is a production-grade, complex application that requires careful planning and execution. The spec provides a comprehensive roadmap for building the VetBens Foundation platform using modern technologies (Next.js 16.1.1, React 19, Supabase, Tailwind 4.0) with advanced features like vector search for intelligent secondary condition discovery.

The implementation will be broken down into 6 phases, each with specific deliverables and verification steps.
