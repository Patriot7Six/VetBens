-- Seed data for VetBens Foundation
-- Run this script after running 001_initial_schema.sql

-- ============================================
-- CATEGORIES
-- ============================================
-- Insert 15 comprehensive disability categories

INSERT INTO categories (name, slug, description) VALUES
  ('Autoimmune', 'autoimmune', 'Conditions where the immune system attacks the body''s own tissues'),
  ('Cardiovascular', 'cardiovascular', 'Heart and blood vessel related conditions'),
  ('Neurological', 'neurological', 'Conditions affecting the brain, spinal cord, and nervous system'),
  ('Musculoskeletal', 'musculoskeletal', 'Conditions affecting bones, muscles, joints, and connective tissues'),
  ('Mental Health', 'mental-health', 'Psychiatric and psychological conditions including PTSD, depression, and anxiety'),
  ('Respiratory', 'respiratory', 'Conditions affecting lungs and breathing'),
  ('Endocrine', 'endocrine', 'Hormonal and metabolic disorders including diabetes and thyroid conditions'),
  ('Gastrointestinal', 'gastrointestinal', 'Digestive system conditions affecting stomach, intestines, and related organs'),
  ('Dermatological', 'dermatological', 'Skin conditions and disorders'),
  ('Genitourinary', 'genitourinary', 'Conditions affecting kidneys, bladder, and reproductive organs'),
  ('Auditory', 'auditory', 'Hearing loss, tinnitus, and ear-related conditions'),
  ('Visual', 'visual', 'Eye conditions and vision impairments'),
  ('Cancer', 'cancer', 'Malignant neoplasms and cancer-related conditions'),
  ('Infectious Disease', 'infectious-disease', 'Conditions caused by bacterial, viral, or parasitic infections'),
  ('Other', 'other', 'Conditions not classified in other categories')
ON CONFLICT (slug) DO NOTHING;

-- ============================================
-- VSO ORGANIZATIONS
-- ============================================
-- Insert major Veteran Service Organizations

INSERT INTO vso_organizations (name, abbreviation, description, website_url, logo_url) VALUES
  (
    'Disabled American Veterans',
    'DAV',
    'The DAV provides free, professional assistance to veterans and their families in obtaining benefits and services earned through military service. With a nationwide network of service officers, DAV helps veterans file claims, gather evidence, and navigate the VA system.',
    'https://www.dav.org',
    NULL
  ),
  (
    'The American Legion',
    'TAL',
    'The American Legion is the nation''s largest wartime veterans service organization, committed to mentoring youth and sponsorship of wholesome programs in communities, advocating patriotism and honor, promoting strong national security, and continued devotion to fellow servicemembers and veterans.',
    'https://www.legion.org',
    NULL
  ),
  (
    'Veterans of Foreign Wars',
    'VFW',
    'The VFW is dedicated to ensuring that veterans are respected for their service, always receive their earned entitlements, and are recognized for the sacrifices they and their loved ones have made on behalf of this great country. VFW provides claims assistance and representation.',
    'https://www.vfw.org',
    NULL
  ),
  (
    'American Veterans',
    'AMVETS',
    'AMVETS has been helping veterans since 1944, providing support for veterans and their families through service programs, legislative advocacy, and community outreach. They offer free assistance with VA claims and benefits.',
    'https://www.amvets.org',
    NULL
  ),
  (
    'Veterans of America',
    'VVA',
    'Vietnam Veterans of America is the only national Vietnam veterans organization chartered by Congress. VVA is dedicated to the needs of Vietnam-era veterans and their families, offering claims assistance and advocacy.',
    'https://vva.org',
    NULL
  ),
  (
    'Paralyzed Veterans of America',
    'PVA',
    'PVA is the only congressionally chartered veterans service organization dedicated solely to the benefit and representation of veterans with spinal cord injury or disease. They provide free claims assistance and advocacy.',
    'https://www.pva.org',
    NULL
  )
ON CONFLICT (abbreviation) DO NOTHING;

-- Verify the inserts
DO $$
DECLARE
  category_count INTEGER;
  vso_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO category_count FROM categories;
  SELECT COUNT(*) INTO vso_count FROM vso_organizations;
  
  RAISE NOTICE 'Categories inserted: %', category_count;
  RAISE NOTICE 'VSO Organizations inserted: %', vso_count;
  
  IF category_count < 13 THEN
    RAISE WARNING 'Expected at least 13 categories, but found %', category_count;
  END IF;
  
  IF vso_count < 3 THEN
    RAISE WARNING 'Expected at least 3 VSO organizations, but found %', vso_count;
  END IF;
END $$;
