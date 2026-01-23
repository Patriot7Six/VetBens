'use client';

import { CATEGORIES } from '@/lib/constants/categories';
import { cn } from '@/lib/utils/cn';

interface CategoryFilterProps {
  selectedCategory: string | null;
  onCategoryChange: (category: string | null) => void;
}

export function CategoryFilter({ selectedCategory, onCategoryChange }: CategoryFilterProps) {
  return (
    <div className="w-full">
      <div className="flex gap-2 overflow-x-auto pb-2 scrollbar-hide">
        <button
          onClick={() => onCategoryChange(null)}
          className={cn(
            'px-4 py-2 rounded-full text-sm font-medium whitespace-nowrap transition-all duration-200 flex-shrink-0',
            selectedCategory === null
              ? 'bg-accent text-white shadow-md'
              : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'
          )}
        >
          All Categories
        </button>
        
        {CATEGORIES.map((category) => (
          <button
            key={category.slug}
            onClick={() => onCategoryChange(category.slug)}
            className={cn(
              'px-4 py-2 rounded-full text-sm font-medium whitespace-nowrap transition-all duration-200 flex-shrink-0',
              selectedCategory === category.slug
                ? 'bg-accent text-white shadow-md'
                : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'
            )}
          >
            {category.name}
          </button>
        ))}
      </div>
    </div>
  );
}
