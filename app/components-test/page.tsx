'use client';

import { Button } from '@/components/ui/Button';
import { Card, CardHeader, CardTitle, CardContent, CardFooter } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';

export default function ComponentsTestPage() {
  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-6xl mx-auto space-y-12">
        <section>
          <h2 className="text-2xl font-bold mb-4 text-navy">Button Component</h2>
          <div className="space-y-4">
            <div className="flex gap-3 flex-wrap">
              <Button variant="primary">Primary</Button>
              <Button variant="secondary">Secondary</Button>
              <Button variant="ghost">Ghost</Button>
              <Button variant="outline">Outline</Button>
            </div>
            <div className="flex gap-3 flex-wrap items-end">
              <Button size="sm">Small</Button>
              <Button size="md">Medium</Button>
              <Button size="lg">Large</Button>
            </div>
            <div className="flex gap-3 flex-wrap">
              <Button loading>Loading</Button>
              <Button disabled>Disabled</Button>
              <Button leftIcon={<span>→</span>}>With Left Icon</Button>
              <Button rightIcon={<span>←</span>}>With Right Icon</Button>
            </div>
          </div>
        </section>

        <section>
          <h2 className="text-2xl font-bold mb-4 text-navy">Card Component</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Card variant="default">
              <CardHeader>
                <CardTitle>Default Card</CardTitle>
              </CardHeader>
              <CardContent>
                This is a default card with border styling.
              </CardContent>
            </Card>

            <Card variant="elevated">
              <CardHeader>
                <CardTitle>Elevated Card</CardTitle>
              </CardHeader>
              <CardContent>
                This card has a shadow for elevation effect.
              </CardContent>
            </Card>

            <Card variant="outline" hover>
              <CardHeader>
                <CardTitle>Outline Card</CardTitle>
              </CardHeader>
              <CardContent>
                This card has a border and hover effect.
              </CardContent>
            </Card>
          </div>

          <Card variant="elevated" padding="lg" className="mt-4">
            <CardHeader>
              <CardTitle>Card with Footer</CardTitle>
            </CardHeader>
            <CardContent>
              This card demonstrates all sub-components including a footer.
            </CardContent>
            <CardFooter>
              <Button size="sm">Action</Button>
            </CardFooter>
          </Card>
        </section>

        <section>
          <h2 className="text-2xl font-bold mb-4 text-navy">Badge Component</h2>
          <div className="space-y-4">
            <div className="flex gap-2 flex-wrap">
              <Badge variant="default">Default</Badge>
              <Badge variant="rating">100%</Badge>
              <Badge variant="dcCode">5010</Badge>
            </div>
            <div className="flex gap-2 flex-wrap">
              <Badge variant="weak">Weak</Badge>
              <Badge variant="moderate">Moderate</Badge>
              <Badge variant="strong">Strong</Badge>
            </div>
            <div className="flex gap-2 flex-wrap">
              <Badge variant="success">Success</Badge>
              <Badge variant="warning">Warning</Badge>
              <Badge variant="error">Error</Badge>
            </div>
            <div className="flex gap-2 flex-wrap items-end">
              <Badge size="sm">Small</Badge>
              <Badge size="md">Medium</Badge>
              <Badge size="lg">Large</Badge>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}
