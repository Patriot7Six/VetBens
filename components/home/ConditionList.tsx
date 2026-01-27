'use client';

import { Condition } from '@/types';
import ConditionCard from './ConditionCard';

export interface ConditionListProps {
  conditions: Condition[];
  selectedConditions: Set<string>;
  onToggleCondition: (conditionId: string) => void;
  isLoading?: boolean;
  emptyMessage?: string;
}

export default function ConditionList({
  conditions,
  selectedConditions,
  onToggleCondition,
  isLoading = false,
  emptyMessage = 'No conditions found. Try adjusting your search or filters.',
}: ConditionListProps) {
  if (isLoading) {
    return (
      <div className="space-y-4" aria-label="Loading conditions">
        {[...Array(6)].map((_, i) => (
          <div key={i} className="animate-pulse">
            <div className="h-32 bg-slate-700 rounded-lg" />
          </div>
        ))}
      </div>
    );
  }

  if (conditions.length === 0) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-400 text-lg">{emptyMessage}</p>
      </div>
    );
  }

  return (
    <div className="space-y-4" role="list" aria-label="Conditions list">
      {conditions.map((condition) => (
        <div key={condition.id} role="listitem">
          <ConditionCard
            condition={condition}
            isSelected={selectedConditions.has(condition.id)}
            onToggle={onToggleCondition}
          />
        </div>
      ))}
    </div>
  );
}
