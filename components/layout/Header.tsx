'use client';

import Link from 'next/link';
import Image from 'next/image';
import { useState } from 'react';

export default function Header() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  return (
    <header className="bg-navy border-b border-navy-light">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          <Link href="/" className="flex items-center gap-3 hover:opacity-90 transition-opacity">
            <Image
              src="/logo.svg"
              alt="Patriot 7Six Logo"
              width={40}
              height={40}
              className="w-10 h-10"
            />
            <div className="flex flex-col">
              <span className="text-white font-bold text-lg leading-tight">
                Patriot <span className="text-accent">7</span>Six
              </span>
              <span className="text-gray-400 text-xs font-medium">
                Veterans Benefits Resource
              </span>
            </div>
          </Link>

          <nav className="hidden md:flex items-center gap-8">
            <Link
              href="/"
              className="text-white hover:text-accent transition-colors text-sm font-medium"
            >
              Home
            </Link>
            <Link
              href="/about"
              className="text-white hover:text-accent transition-colors text-sm font-medium"
            >
              About
            </Link>
            <Link
              href="/resources"
              className="text-white hover:text-accent transition-colors text-sm font-medium"
            >
              Resources
            </Link>
            <Link
              href="/contact"
              className="text-white hover:text-accent transition-colors text-sm font-medium"
            >
              Contact
            </Link>
          </nav>

          <button
            className="md:hidden text-white p-2 hover:text-accent transition-colors"
            aria-label={mobileMenuOpen ? 'Close menu' : 'Open menu'}
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
          >
            {mobileMenuOpen ? (
              <svg
                className="w-6 h-6"
                fill="none"
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path d="M6 18L18 6M6 6l12 12" />
              </svg>
            ) : (
              <svg
                className="w-6 h-6"
                fill="none"
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            )}
          </button>
        </div>

        {mobileMenuOpen && (
          <nav className="md:hidden py-4 border-t border-navy-light">
            <div className="flex flex-col space-y-4">
              <Link
                href="/"
                className="text-white hover:text-accent transition-colors text-sm font-medium"
                onClick={() => setMobileMenuOpen(false)}
              >
                Home
              </Link>
              <Link
                href="/about"
                className="text-white hover:text-accent transition-colors text-sm font-medium"
                onClick={() => setMobileMenuOpen(false)}
              >
                About
              </Link>
              <Link
                href="/resources"
                className="text-white hover:text-accent transition-colors text-sm font-medium"
                onClick={() => setMobileMenuOpen(false)}
              >
                Resources
              </Link>
              <Link
                href="/contact"
                className="text-white hover:text-accent transition-colors text-sm font-medium"
                onClick={() => setMobileMenuOpen(false)}
              >
                Contact
              </Link>
            </div>
          </nav>
        )}
      </div>
    </header>
  );
}
