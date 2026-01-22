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
