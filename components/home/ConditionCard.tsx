'use client';

import { useState } from 'react';
import { Condition } from '@/types';
import { Card, CardContent } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';
import { cn } from '@/lib/utils/cn';

export interface ConditionCardProps {
  condition: Condition;
  isSelected: boolean;
  onToggle: (conditionId: string) => void;
}

export default function ConditionCard({ condition, isSelected, onToggle }: ConditionCardProps) {
  const [isExpanded, setIsExpanded] = useState(false);
  const descriptionLimit = 150;
  const shouldTruncate = condition.description.length > descriptionLimit;
  const displayDescription = isExpanded || !shouldTruncate
    ? condition.description
    : `${condition.description.slice(0, descriptionLimit)}...`;

  return (
    <Card
      variant="elevated"
      padding="md"
      hover
      className={cn(
        'transition-all border-2',
        isSelected ? 'border-accent shadow-lg' : 'border-transparent'
      )}
      onClick={() => onToggle(condition.id)}
    >
      <CardContent className="p-0">
        <div className="flex items-start gap-3">
          <div className="flex-shrink-0 pt-1">
            <input
              type="checkbox"
              checked={isSelected}
              onChange={() => onToggle(condition.id)}
              onClick={(e) => e.stopPropagation()}
              className="w-5 h-5 text-accent bg-white border-gray-300 rounded focus:ring-accent focus:ring-2 cursor-pointer"
              aria-label={`Select ${condition.name}`}
            />
          </div>

          <div className="flex-1 min-w-0">
            <div className="flex items-start justify-between gap-2 mb-2">
              <h3 className="text-lg font-semibold text-navy leading-tight">
                {condition.name}
              </h3>
              <Badge variant="dcCode" size="sm" className="flex-shrink-0">
                {condition.dc_code}
              </Badge>
            </div>

            {condition.category && (
              <p className="text-sm text-gray-500 mb-2">
                {condition.category.name}
              </p>
            )}

            <p className="text-sm text-gray-700 mb-3 leading-relaxed">
              {displayDescription}
              {shouldTruncate && (
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    setIsExpanded(!isExpanded);
                  }}
                  className="ml-1 text-accent hover:text-accent-dark font-medium focus:outline-none focus:underline"
                  aria-label={isExpanded ? 'Show less' : 'Show more'}
                >
                  {isExpanded ? 'Show less' : 'Show more'}
                </button>
              )}
            </p>

            <div className="flex flex-wrap gap-2">
              <span className="text-xs text-gray-500 font-medium">Ratings:</span>
              {condition.rating_percentages.map((rating) => (
                <Badge key={rating} variant="rating" size="sm">
                  {rating}%
                </Badge>
              ))}
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
