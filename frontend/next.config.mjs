import { readFileSync } from 'fs';
import { join } from 'path';

async function rewrites() {
  return [
    {
      source: '/api/v1/:path*',
      destination: 'http://localhost:4000/api/v1/:path*',
    },
  ]
}

if (process.env.NODE_ENV === 'production') {
  rewrites = () => [];
}

const version = readFileSync(join(process.cwd(), 'VERSION'), 'utf8').trim();

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: 'export',
  env: {
    APP_VERSION: version,
  },
  rewrites,
};

export default nextConfig;
