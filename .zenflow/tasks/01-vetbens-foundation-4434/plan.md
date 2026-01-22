# Spec and build

## Configuration
- **Artifacts Path**: {@artifacts_path} → `.zenflow/tasks/{task_id}`

---

## Agent Instructions

Ask the user questions when anything is unclear or needs their input. This includes:
- Ambiguous or incomplete requirements
- Technical decisions that affect architecture or user experience
- Trade-offs that require business context

Do not make assumptions on important decisions — get clarification first.

---

## Workflow Steps

### [x] Step: Technical Specification
<!-- chat-id: 86a7907c-cdd8-43c0-b063-2b5fb8aaed1f -->

Assess the task's difficulty, as underestimating it leads to poor outcomes.
- easy: Straightforward implementation, trivial bug fix or feature
- medium: Moderate complexity, some edge cases or caveats to consider
- hard: Complex logic, many caveats, architectural considerations, or high-risk changes

Create a technical specification for the task that is appropriate for the complexity level:
- Review the existing codebase architecture and identify reusable components.
- Define the implementation approach based on established patterns in the project.
- Identify all source code files that will be created or modified.
- Define any necessary data model, API, or interface changes.
- Describe verification steps using the project's test and lint commands.

Save the output to `{@artifacts_path}/spec.md` with:
- Technical context (language, dependencies)
- Implementation approach
- Source code structure changes
- Data model / API / interface changes
- Verification approach

If the task is complex enough, create a detailed implementation plan based on `{@artifacts_path}/spec.md`:
- Break down the work into concrete tasks (incrementable, testable milestones)
- Each task should reference relevant contracts and include verification steps
- Replace the Implementation step below with the planned tasks

Rule of thumb for step size: each step should represent a coherent unit of work (e.g., implement a component, add an API endpoint, write tests for a module). Avoid steps that are too granular (single function).

Save to `{@artifacts_path}/plan.md`. If the feature is trivial and doesn't warrant this breakdown, keep the Implementation step below as is.

---

### [x] Step 1: Project Setup & Infrastructure
<!-- chat-id: 0a951927-2d57-410f-930a-37e5901eaa40 -->

Initialize the Next.js project with all required dependencies and configurations.

**Tasks**:
- Initialize Next.js 16.1.1 project with TypeScript 5.7.2 and App Router
- Install and configure Tailwind CSS 4.0
- Install Supabase dependencies (@supabase/supabase-js, @supabase/ssr)
- Install additional dependencies (react-icons, etc.)
- Configure TypeScript (tsconfig.json)
- Configure Tailwind (tailwind.config.ts)
- Create project folder structure (app/, components/, lib/, types/)
- Set up .env.local with Supabase placeholders
- Create .gitignore file
- Create basic layout.tsx and page.tsx

**Verification**:
- `npm run dev` starts without errors
- `npx tsc --noEmit` passes without errors
- Tailwind classes render correctly
- Project structure matches spec

---

### [x] Step 2: Supabase Setup & Database Schema
<!-- chat-id: 19cffd88-33d3-41d0-9c0a-2f5033605775 -->

Set up Supabase project and create database schema.

**Tasks**:
- Create Supabase project
- Enable pgvector extension
- Create migration file: `001_initial_schema.sql`
- Create tables: categories, conditions, secondary_relationships, vso_organizations
- Create vector search function: `match_conditions`
- Create indexes for performance
- Update .env.local with actual Supabase credentials
- Create Supabase client utilities (lib/supabase/client.ts, lib/supabase/server.ts)
- Generate TypeScript types from database schema

**Verification**:
- Tables created successfully in Supabase dashboard
- pgvector extension enabled
- Supabase client connects without errors
- TypeScript types generated

---

### [x] Step 3: Database Seeding - Categories & VSO Organizations
<!-- chat-id: e40b813d-9682-4738-889c-8ce6766d0efe -->

Seed reference data that doesn't change frequently.

**Tasks**:
- Create seed file: `supabase/seed.sql`
- Seed 13+ categories (Autoimmune, Cardiovascular, Neurological, etc.)
- Seed VSO organizations (DAV, American Legion, VFW)
- Run seed script in Supabase
- Create constants file: `lib/constants/categories.ts`
- Create constants file: `lib/constants/vso.ts`

**Verification**:
- Query categories table: should have 13+ records
- Query vso_organizations table: should have 3+ records
- Constants files export correct data

---

### [ ] Step 4: Database Seeding - Conditions Data

Seed initial conditions with DC codes and ratings (start with 50-100 conditions).

**Tasks**:
- Research and compile condition data from VA resources
- Create seed data with: name, dc_code, description, category_id, rating_percentages
- Insert conditions into database
- Verify data integrity (unique DC codes, valid categories)

**Verification**:
- Query conditions table: should have 50-100 records
- All DC codes are unique
- All rating_percentages arrays are valid
- Each condition has a valid category_id

---

### [ ] Step 5: Vector Embeddings Generation

Generate and store embeddings for all conditions.

**Tasks**:
- Create embedding utility: `lib/utils/embeddings.ts`
- Create script to generate embeddings using OpenAI API
- Update conditions table with embeddings
- Verify vector index is working
- Test vector search function

**Verification**:
- All conditions have embeddings (1536 dimensions)
- Vector search returns similar conditions
- Performance is acceptable (< 500ms for search)

---

### [ ] Step 6: Secondary Relationships Seeding

Manually curate initial secondary condition relationships.

**Tasks**:
- Research medical literature for secondary connections
- Create seed data for secondary_relationships table
- Include connection_strength, potential_rating_range, explanation
- Insert relationships into database
- Verify bidirectional relationships where applicable

**Verification**:
- Query secondary_relationships table: should have 50+ records
- Test queries for specific primary conditions return secondaries
- Connection strengths are valid ('weak', 'moderate', 'strong')

---

### [ ] Step 7: Reusable UI Components

Build foundational UI components using Tailwind CSS 4.0.

**Tasks**:
- Create `components/ui/Button.tsx` - Reusable button with variants
- Create `components/ui/Card.tsx` - Card container component
- Create `components/ui/Badge.tsx` - Badge for ratings, DC codes, connection strength
- Create `lib/utils/cn.ts` - className utility function
- Style components according to design system (navy blue, orange accent)

**Verification**:
- Components render correctly
- Variants and props work as expected
- TypeScript types are correct
- No console errors

---

### [ ] Step 8: Layout Components

Create header and footer for the application.

**Tasks**:
- Create `components/layout/Header.tsx` - Logo and navigation
- Create `components/layout/Footer.tsx` - Footer with links
- Update `app/layout.tsx` to include Header and Footer
- Add Patriot7Six logo to public/logo.svg
- Style with dark navy background and responsive design

**Verification**:
- Header appears on all pages
- Footer appears on all pages
- Logo renders correctly
- Layout is responsive

---

### [ ] Step 9: Hero Section & Feature Cards

Build the landing page hero and feature highlights.

**Tasks**:
- Create `components/home/Hero.tsx` - Hero section with headline
- Create `components/home/FeatureCards.tsx` - 3 feature cards
- Style with gradient background, centered text, large typography
- Add icons for each feature card
- Integrate into `app/page.tsx`

**Verification**:
- Hero section displays correctly
- Feature cards render in grid layout
- Responsive design works on mobile
- Matches reference design

---

### [ ] Step 10: Search Bar Component

Build search functionality with autocomplete.

**Tasks**:
- Create `components/home/SearchBar.tsx`
- Implement search input with icon
- Add debounced search (300ms delay)
- Style with navy blue background and rounded borders
- Add placeholder text

**Verification**:
- Search input renders correctly
- Debouncing works (doesn't trigger on every keystroke)
- Styling matches design
- TypeScript types are correct

---

### [ ] Step 11: Category Filter Component

Build category filtering UI.

**Tasks**:
- Create `components/home/CategoryFilter.tsx`
- Display category chips/pills in horizontal scrollable layout
- Implement "All Categories" option
- Add active state styling (orange accent)
- Make responsive (scrollable on mobile)

**Verification**:
- All categories display correctly
- Clicking category filters conditions
- Active state is visually clear
- Horizontal scroll works on mobile

---

### [ ] Step 12: Condition Card & List Components

Build components to display individual conditions and lists.

**Tasks**:
- Create `components/home/ConditionCard.tsx` - Individual condition with checkbox
- Display: name, DC code, description (truncated), rating badges
- Create `components/home/ConditionList.tsx` - List container
- Add checkbox selection logic
- Style with card backgrounds and hover effects

**Verification**:
- Condition cards render correctly
- Checkboxes toggle selection
- Rating badges display properly
- Hover effects work
- Truncated text has expand option

---

### [ ] Step 13: API Route - Get Conditions

Create API endpoint to fetch conditions with search and filters.

**Tasks**:
- Create `app/api/conditions/route.ts`
- Implement GET handler with query params: search, category, limit, offset
- Query Supabase with filters and search
- Join with categories table
- Return JSON response with conditions array and total count
- Add error handling

**Verification**:
- GET /api/conditions returns all conditions
- GET /api/conditions?search=lupus returns filtered results
- GET /api/conditions?category=autoimmune returns filtered results
- Error handling works (returns 500 on errors)
- Response matches TypeScript types

---

### [ ] Step 14: Condition Selector Integration

Integrate all condition selection components together.

**Tasks**:
- Create `components/home/ConditionSelector.tsx`
- Integrate SearchBar, CategoryFilter, ConditionList
- Implement state management for: selectedCategory, searchQuery, selectedConditions
- Fetch conditions from API based on filters
- Handle loading and error states
- Add "No results" state

**Verification**:
- Filtering by category works
- Search works
- Selecting conditions updates state
- Loading states display correctly
- Error states display correctly
- No results state displays when appropriate

---

### [ ] Step 15: API Route - Get Secondary Conditions

Create API endpoint to discover secondary conditions.

**Tasks**:
- Create `app/api/secondary/route.ts`
- Implement POST handler accepting condition_ids array
- Query secondary_relationships table for matches
- Optionally use vector search for additional suggestions
- Combine manual + vector search results
- Return secondary conditions with connection info
- Add error handling

**Verification**:
- POST /api/secondary with condition_ids returns secondaries
- Results include connection_strength and explanation
- Vector search enhances results
- No duplicate results
- Error handling works

---

### [ ] Step 16: Secondary Results Component

Display discovered secondary conditions.

**Tasks**:
- Create `components/home/SecondaryResults.tsx`
- Display results grouped by connection strength
- Show condition name, DC code, explanation, potential rating
- Add connection strength badges (color-coded)
- Make expandable for full details
- Add "0 conditions found" state

**Verification**:
- Results display correctly when conditions selected
- Grouping by connection strength works
- Badges are color-coded correctly
- Expand/collapse works
- Empty state displays when no selections

---

### [ ] Step 17: Actions Bar - Print & Share

Implement print and share functionality.

**Tasks**:
- Create `components/home/ActionsBar.tsx`
- Add "Print Results" button - triggers browser print dialog
- Add "Share" button - copies URL to clipboard
- Position sticky or at bottom of results
- Add success toast/notification for share action

**Verification**:
- Print button opens print dialog
- Print layout is clean (hides unnecessary UI)
- Share button copies URL
- Success notification appears
- Buttons are accessible

---

### [ ] Step 18: VSO Assistance Section

Build section showing veteran service organizations.

**Tasks**:
- Create `components/home/VSOAssistance.tsx`
- Fetch VSO data from Supabase or constants
- Display in card grid (3 columns on desktop)
- Include name, description, and external link
- Style with orange background
- Add external link icon

**Verification**:
- VSO cards display correctly
- Links open in new tab
- Grid is responsive (1 column on mobile)
- Styling matches reference design

---

### [ ] Step 19: Responsive Design & Polish

Ensure the entire application works across all device sizes.

**Tasks**:
- Test on mobile (375px), tablet (768px), desktop (1280px+)
- Fix any layout issues
- Ensure touch targets are large enough on mobile
- Add loading skeletons where appropriate
- Optimize images and assets
- Add smooth transitions and animations (optional)

**Verification**:
- Mobile layout works perfectly
- Tablet layout works perfectly
- Desktop layout works perfectly
- No horizontal scrolling on any device
- Touch targets are accessible (minimum 44px)

---

### [ ] Step 20: SEO & Metadata

Add proper metadata and SEO optimization.

**Tasks**:
- Update `app/layout.tsx` with metadata
- Add title, description, Open Graph tags
- Add favicon
- Add robots.txt
- Add sitemap.xml (if needed)
- Optimize for social sharing

**Verification**:
- Page title displays correctly
- Meta description is present
- Open Graph tags work (test with social media debuggers)
- Favicon appears in browser tab

---

### [ ] Step 21: Error Handling & Edge Cases

Add comprehensive error handling.

**Tasks**:
- Add error boundaries in `app/error.tsx`
- Handle API errors gracefully
- Handle empty states (no results, no selections)
- Add retry logic where appropriate
- Test offline behavior
- Add loading states everywhere

**Verification**:
- API errors don't crash the app
- Empty states display helpful messages
- Offline shows appropriate message
- Loading states are smooth
- No console errors in production

---

### [ ] Step 22: Performance Optimization

Optimize application performance.

**Tasks**:
- Implement pagination for conditions list
- Add lazy loading for images
- Optimize bundle size (analyze with `npm run build`)
- Use React Server Components where appropriate
- Add caching headers for API routes
- Optimize Supabase queries (add indexes if needed)

**Verification**:
- Lighthouse score > 90
- Time to First Byte < 600ms
- First Contentful Paint < 1.8s
- Total bundle size < 500KB
- No unnecessary re-renders

---

### [ ] Step 23: Manual Testing & QA

Comprehensive testing of all features.

**Tasks**:
- Test all user flows (search, filter, select, results)
- Test on Chrome, Firefox, Safari
- Test on iOS and Android devices
- Test edge cases (special characters in search, etc.)
- Verify data accuracy (spot check conditions and relationships)
- Check accessibility (keyboard navigation, screen readers)

**Verification**:
- All features work as expected
- No bugs found
- Cross-browser compatibility confirmed
- Mobile experience is smooth
- Data is accurate

---

### [ ] Step 24: Deployment to Vercel

Deploy the application to production.

**Tasks**:
- Connect GitHub repo to Vercel
- Configure environment variables in Vercel dashboard
- Deploy to Vercel
- Test production deployment
- Configure custom domain (if applicable)
- Set up analytics (Vercel Analytics)

**Verification**:
- Production site is live and accessible
- All environment variables are configured
- Site works identically to local development
- No console errors in production
- Domain configured (if applicable)

---

### [ ] Step 25: Final Report

Document the implementation and results.

**Tasks**:
- Write report to `.zenflow/tasks/01-vetbens-foundation-4434/report.md`
- Describe what was implemented
- Describe how the solution was tested
- Note the biggest issues or challenges encountered
- Provide production URL
- List any future improvements or known issues

**Verification**:
- Report is comprehensive and clear
- All sections are complete
- Production URL is included
