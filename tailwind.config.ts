import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        navy: {
          DEFAULT: '#001f3f',
          dark: '#001529',
          light: '#003366',
        },
        orange: {
          DEFAULT: '#ff6b35',
          light: '#ff8c61',
          dark: '#e65522',
        },
      },
    },
  },
  plugins: [],
};

export default config;
