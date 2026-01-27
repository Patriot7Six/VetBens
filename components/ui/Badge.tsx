import { HTMLAttributes, forwardRef } from 'react';
import { cn } from '@/lib/utils/cn';

/**
 * Badge component for displaying labels, tags, and status indicators.
 * Supports multiple variants including ratings, DC codes, and connection strengths.
 * 
 * @example
 * <Badge variant="rating">100%</Badge>
 * <Badge variant="dcCode">5010</Badge>
 * <Badge variant="strong">Strong Connection</Badge>
 */
export interface BadgeProps extends HTMLAttributes<HTMLSpanElement> {
  variant?: 'default' | 'rating' | 'dcCode' | 'weak' | 'moderate' | 'strong' | 'success' | 'warning' | 'error';
  size?: 'sm' | 'md' | 'lg';
}

const Badge = forwardRef<HTMLSpanElement, BadgeProps>(
  ({ className, variant = 'default', size = 'md', children, ...props }, ref) => {
    const baseStyles = 'inline-flex items-center justify-center font-medium rounded-full transition-colors';
    
    const variants = {
      default: 'bg-gray-200 text-gray-800',
      rating: 'bg-accent text-white',
      dcCode: 'bg-navy text-white',
      weak: 'bg-connection-weak text-gray-900',
      moderate: 'bg-connection-moderate text-white',
      strong: 'bg-connection-strong text-white',
      success: 'bg-success text-white',
      warning: 'bg-warning text-white',
      error: 'bg-error text-white',
    };

    const sizes = {
      sm: 'px-2 py-0.5 text-xs',
      md: 'px-3 py-1 text-sm',
      lg: 'px-4 py-1.5 text-base',
    };

    return (
      <span
        ref={ref}
        className={cn(baseStyles, variants[variant], sizes[size], className)}
        {...props}
      >
        {children}
      </span>
    );
  }
);

Badge.displayName = 'Badge';

export { Badge };
