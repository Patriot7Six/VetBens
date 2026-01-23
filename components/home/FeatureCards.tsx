import { FaMedal, FaArrowTrendUp, FaClipboardList } from 'react-icons/fa6';
import { Card } from '@/components/ui/Card';

const features = [
  {
    icon: FaMedal,
    title: '321 Conditions',
    description: 'Comprehensive Database',
  },
  {
    icon: FaArrowTrendUp,
    title: 'Increase Rating',
    description: 'Maximize Benefits',
  },
  {
    icon: FaClipboardList,
    title: 'Documentation',
    description: 'Checklists Included',
  },
];

export default function FeatureCards() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-6xl mx-auto px-4 py-12">
      {features.map((feature) => (
        <Card
          key={feature.title}
          padding="lg"
          className="text-center bg-navy-light border border-navy-light hover:border-orange transition-colors"
        >
          <div className="flex justify-center mb-6">
            <feature.icon className="text-orange text-5xl" />
          </div>
          <h3 className="text-2xl font-bold text-white mb-2">
            {feature.title}
          </h3>
          <p className="text-gray-300">{feature.description}</p>
        </Card>
      ))}
    </div>
  );
}
