import Link from 'next/link';
import Image from 'next/image';

export default function Header() {
  return (
    <header className="bg-[#0A1F44] border-b border-[#1a3a5c]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          <Link href="/" className="flex items-center gap-3 hover:opacity-90 transition-opacity">
            <Image
              src="/logo.svg"
              alt="VetBens Foundation Logo"
              width={40}
              height={40}
              className="w-10 h-10"
            />
            <div className="flex flex-col">
              <span className="text-white font-bold text-lg leading-tight">
                VetBens Foundation
              </span>
              <span className="text-[#FF6B35] text-xs font-medium">
                Powered by Patriot7Six
              </span>
            </div>
          </Link>

          <nav className="hidden md:flex items-center gap-8">
            <Link
              href="/"
              className="text-white hover:text-[#FF6B35] transition-colors text-sm font-medium"
            >
              Home
            </Link>
            <Link
              href="/about"
              className="text-white hover:text-[#FF6B35] transition-colors text-sm font-medium"
            >
              About
            </Link>
            <Link
              href="/resources"
              className="text-white hover:text-[#FF6B35] transition-colors text-sm font-medium"
            >
              Resources
            </Link>
            <Link
              href="/contact"
              className="text-white hover:text-[#FF6B35] transition-colors text-sm font-medium"
            >
              Contact
            </Link>
          </nav>

          <button
            className="md:hidden text-white p-2"
            aria-label="Open menu"
          >
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
          </button>
        </div>
      </div>
    </header>
  );
}
