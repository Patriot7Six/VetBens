# Supabase Setup Guide

## Step 1: Create Supabase Project

1. Go to [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Click "New Project"
3. Fill in the details:
   - **Name**: VetBens Foundation
   - **Database Password**: Choose a strong password (save this!)
   - **Region**: Choose closest to your users
   - **Pricing Plan**: Free tier is fine for development
4. Click "Create new project" and wait for provisioning (~2 minutes)

## Step 2: Run Database Migration

### Option A: Using Supabase Dashboard (Recommended)

1. In your Supabase project dashboard, go to **SQL Editor** (left sidebar)
2. Click "New Query"
3. Copy the entire contents of `supabase/migrations/001_initial_schema.sql`
4. Paste into the SQL editor
5. Click "Run" or press Ctrl+Enter
6. Verify success - you should see "Success. No rows returned"

### Option B: Using Supabase CLI

If you have the Supabase CLI installed:

```bash
supabase db push
```

## Step 3: Verify Database Setup

1. Go to **Table Editor** in the Supabase dashboard
2. You should see 4 tables:
   - `categories`
   - `conditions`
   - `secondary_relationships`
   - `vso_organizations`
3. Go to **Database** > **Extensions** and verify `vector` is enabled

## Step 4: Get API Credentials

1. In your Supabase project dashboard, go to **Project Settings** (gear icon)
2. Click **API** in the left menu
3. Copy the following values:
   - **Project URL** (under "Project URL")
   - **anon/public key** (under "Project API keys")

## Step 5: Update Environment Variables

Update your `.env.local` file with the credentials:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
```

Replace the placeholder values with your actual credentials from Step 4.

## Step 6: Test Connection

Run the development server:

```bash
npm run dev
```

The application should now connect to Supabase without errors.

## Troubleshooting

### pgvector extension not enabled
- Go to **Database** > **Extensions**
- Search for "vector"
- Click "Enable" next to pgvector

### Migration fails
- Make sure your Supabase project is fully provisioned (check dashboard)
- Verify you copied the entire migration file
- Check for any error messages in the SQL editor

### Connection errors
- Double-check your `.env.local` file has the correct values
- Make sure you're using the **anon/public key**, not the service role key
- Restart your development server after updating `.env.local`
