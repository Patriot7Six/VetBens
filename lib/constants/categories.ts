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
    name: 'Dental/Oral',
    slug: 'dental-oral',
    description: 'Dental and oral health conditions',
  },
  {
    name: 'Dermatological',
    slug: 'dermatological',
    description: 'Skin conditions and disorders',
  },
  {
    name: 'Endocrine',
    slug: 'endocrine',
    description: 'Hormonal disorders including diabetes and thyroid conditions',
  },
  {
    name: 'Gastrointestinal',
    slug: 'gastrointestinal',
    description: 'Digestive system conditions affecting stomach, intestines, and related organs',
  },
  {
    name: 'Genitourinary',
    slug: 'genitourinary',
    description: 'Conditions affecting kidneys, bladder, and reproductive organs',
  },
  {
    name: 'Gynecological',
    slug: 'gynecological',
    description: 'Women\'s reproductive health conditions',
  },
  {
    name: 'Hearing',
    slug: 'hearing',
    description: 'Hearing loss, tinnitus, and ear-related conditions',
  },
  {
    name: 'Mental Health',
    slug: 'mental-health',
    description: 'Psychiatric and psychological conditions including PTSD, depression, and anxiety',
  },
  {
    name: 'Metabolic',
    slug: 'metabolic',
    description: 'Metabolic disorders and conditions',
  },
  {
    name: 'Musculoskeletal',
    slug: 'musculoskeletal',
    description: 'Conditions affecting bones, muscles, joints, and connective tissues',
  },
  {
    name: 'Neurological',
    slug: 'neurological',
    description: 'Conditions affecting the brain, spinal cord, and nervous system',
  },
  {
    name: 'Respiratory',
    slug: 'respiratory',
    description: 'Conditions affecting lungs and breathing',
  },
  {
    name: 'Sleep Disorders',
    slug: 'sleep-disorders',
    description: 'Sleep-related conditions including insomnia and sleep apnea',
  },
  {
    name: 'Vestibular',
    slug: 'vestibular',
    description: 'Balance and inner ear disorders',
  },
  {
    name: 'Vision',
    slug: 'vision',
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
