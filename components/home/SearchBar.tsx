'use client';

import { useState, useEffect, ChangeEvent } from 'react';
import { FiSearch } from 'react-icons/fi';
import { cn } from '@/lib/utils/cn';

export interface SearchBarProps {
  onSearch: (query: string) => void;
  placeholder?: string;
  debounceMs?: number;
  className?: string;
}

export default function SearchBar({ 
  onSearch, 
  placeholder = 'Search conditions (e.g., "PTSD", "knee pain", "diabetes")...', 
  debounceMs = 300,
  className 
}: SearchBarProps) {
  const [inputValue, setInputValue] = useState('');

  useEffect(() => {
    const timer = setTimeout(() => {
      onSearch(inputValue);
    }, debounceMs);

    return () => clearTimeout(timer);
  }, [inputValue, debounceMs, onSearch]);

  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    setInputValue(e.target.value);
  };

  return (
    <div className={cn('relative w-full max-w-3xl mx-auto', className)}>
      <div className="relative">
        <div className="absolute inset-y-0 left-0 flex items-center pl-4 pointer-events-none">
          <FiSearch className="w-5 h-5 text-gray-400" aria-hidden="true" />
        </div>
        <input
          type="text"
          value={inputValue}
          onChange={handleChange}
          placeholder={placeholder}
          className="w-full pl-12 pr-4 py-3 bg-navy-dark border-2 border-navy-light rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-accent focus:border-accent transition-colors"
          aria-label="Search conditions"
        />
      </div>
    </div>
  );
}
