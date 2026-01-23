import Hero from '@/components/home/Hero';
import FeatureCards from '@/components/home/FeatureCards';

export default function Home() {
  return (
    <main className="min-h-screen bg-navy text-white">
      <div className="container mx-auto">
        <Hero />
        <FeatureCards />
      </div>
    </main>
  );
}
