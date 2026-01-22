import { Category } from '@/types';

export const CATEGORIES: Omit<Category, 'id'>[] = [
  {
    name: 'Autoimmune',
    slug: 'autoimmune',
    description: 'Conditions where the immune system attacks the body\'s own tissues',
  },
  {
    name: 'Cardiovascular',
    slug: 'cardiovascular',
    description: 'Heart and blood vessel related conditions',
  },
  {
    name: 'Neurological',
    slug: 'neurological',
    description: 'Conditions affecting the brain, spinal cord, and nervous system',
  },
  {
    name: 'Musculoskeletal',
    slug: 'musculoskeletal',
    description: 'Conditions affecting bones, muscles, joints, and connective tissues',
  },
  {
    name: 'Mental Health',
    slug: 'mental-health',
    description: 'Psychiatric and psychological conditions including PTSD, depression, and anxiety',
  },
  {
    name: 'Respiratory',
    slug: 'respiratory',
    description: 'Conditions affecting lungs and breathing',
  },
  {
    name: 'Endocrine',
    slug: 'endocrine',
    description: 'Hormonal and metabolic disorders including diabetes and thyroid conditions',
  },
  {
    name: 'Gastrointestinal',
    slug: 'gastrointestinal',
    description: 'Digestive system conditions affecting stomach, intestines, and related organs',
  },
  {
    name: 'Dermatological',
    slug: 'dermatological',
    description: 'Skin conditions and disorders',
  },
  {
    name: 'Genitourinary',
    slug: 'genitourinary',
    description: 'Conditions affecting kidneys, bladder, and reproductive organs',
  },
  {
    name: 'Auditory',
    slug: 'auditory',
    description: 'Hearing loss, tinnitus, and ear-related conditions',
  },
  {
    name: 'Visual',
    slug: 'visual',
    description: 'Eye conditions and vision impairments',
  },
  {
    name: 'Cancer',
    slug: 'cancer',
    description: 'Malignant neoplasms and cancer-related conditions',
  },
  {
    name: 'Infectious Disease',
    slug: 'infectious-disease',
    description: 'Conditions caused by bacterial, viral, or parasitic infections',
  },
  {
    name: 'Other',
    slug: 'other',
    description: 'Conditions not classified in other categories',
  },
];

export const getCategoryBySlug = (slug: string): Omit<Category, 'id'> | undefined => {
  return CATEGORIES.find((cat) => cat.slug === slug);
};

export const getCategoryByName = (name: string): Omit<Category, 'id'> | undefined => {
  return CATEGORIES.find((cat) => cat.name === name);
};
