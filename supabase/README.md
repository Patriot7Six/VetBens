# Supabase Database Setup

This directory contains the database schema and seed data for the VetBens Foundation application.

## Files

- `migrations/001_initial_schema.sql` - Database schema with tables, indexes, and functions
- `seed.sql` - Seed data for categories, VSO organizations, and 100 VA disability conditions

## Running Migrations and Seeds

### Option 1: Supabase Dashboard (SQL Editor)

1. Go to your Supabase project dashboard
2. Navigate to the SQL Editor
3. Run the migration file first:
   - Copy contents of `migrations/001_initial_schema.sql`
   - Paste into SQL Editor and run
4. Run the seed file:
   - Copy contents of `seed.sql`
   - Paste into SQL Editor and run

### Option 2: Supabase CLI

```bash
# Login to Supabase
supabase login

# Link to your project
supabase link --project-ref your-project-ref

# Run migrations
supabase db push

# Run seed file
supabase db execute --file supabase/seed.sql
```

## Data Summary

After running the seed file, you should have:

- **15 Categories**: Autoimmune, Cardiovascular, Neurological, Musculoskeletal, Mental Health, Respiratory, Endocrine, Gastrointestinal, Dermatological, Genitourinary, Auditory, Visual, Cancer, Infectious Disease, Other
- **6 VSO Organizations**: DAV, The American Legion, VFW, AMVETS, VVA, PVA
- **100 VA Disability Conditions**: With DC codes, descriptions, categories, and rating percentages

### Conditions by Category

- Autoimmune: 7 conditions
- Cardiovascular: 8 conditions
- Neurological: 9 conditions
- Musculoskeletal: 14 conditions
- Mental Health: 10 conditions
- Respiratory: 8 conditions
- Endocrine: 5 conditions
- Gastrointestinal: 6 conditions
- Dermatological: 5 conditions
- Genitourinary: 6 conditions
- Auditory: 4 conditions
- Visual: 5 conditions
- Cancer: 5 conditions
- Infectious Disease: 4 conditions
- Other: 4 conditions

**Total: 100 conditions**

## Verification

The seed script includes verification logic that will output:
- Number of categories inserted
- Number of VSO organizations inserted
- Number of conditions inserted
- Breakdown of conditions by category
- Warnings for any data integrity issues

Look for these messages in the query results after running the seed file.

## Next Steps

After seeding the database:

1. Verify data in Supabase Table Editor
2. Generate embeddings for conditions (see Step 5 in implementation plan)
3. Continue with application development
