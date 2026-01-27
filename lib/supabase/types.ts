export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export interface Database {
  public: {
    Tables: {
      categories: {
        Row: {
          id: string;
          name: string;
          slug: string;
          description: string | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          slug: string;
          description?: string | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          slug?: string;
          description?: string | null;
          created_at?: string;
        };
      };
      conditions: {
        Row: {
          id: string;
          name: string;
          dc_code: string;
          description: string;
          category_id: string | null;
          rating_percentages: number[];
          embedding: number[] | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          dc_code: string;
          description: string;
          category_id?: string | null;
          rating_percentages: number[];
          embedding?: number[] | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          dc_code?: string;
          description?: string;
          category_id?: string | null;
          rating_percentages?: number[];
          embedding?: number[] | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      secondary_relationships: {
        Row: {
          id: string;
          primary_condition_id: string;
          secondary_condition_id: string;
          connection_strength: 'weak' | 'moderate' | 'strong';
          potential_rating_range: string;
          explanation: string;
          evidence_level: string | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          primary_condition_id: string;
          secondary_condition_id: string;
          connection_strength: 'weak' | 'moderate' | 'strong';
          potential_rating_range: string;
          explanation: string;
          evidence_level?: string | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          primary_condition_id?: string;
          secondary_condition_id?: string;
          connection_strength?: 'weak' | 'moderate' | 'strong';
          potential_rating_range?: string;
          explanation?: string;
          evidence_level?: string | null;
          created_at?: string;
        };
      };
      vso_organizations: {
        Row: {
          id: string;
          name: string;
          abbreviation: string;
          description: string;
          website_url: string;
          logo_url: string | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          abbreviation: string;
          description: string;
          website_url: string;
          logo_url?: string | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          abbreviation?: string;
          description?: string;
          website_url?: string;
          logo_url?: string | null;
          created_at?: string;
        };
      };
    };
  };
}
