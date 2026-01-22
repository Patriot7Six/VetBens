import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'VetBens Foundation - Discover VA Secondary Conditions',
  description: 'Discover potential secondary conditions to increase your VA disability rating. Comprehensive database of 321+ conditions with DC codes and rating percentages.',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
