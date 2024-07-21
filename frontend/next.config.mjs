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
const basePath = (process.env.TA_BASE_PATH || '/').replace(/\/$/, '');

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: 'export',
  basePath,
  env: {
    APP_VERSION: version,
    TA_BASE_PATH: basePath,
  },
  rewrites,
};

export default nextConfig;
