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

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: 'export',
  rewrites,
};

export default nextConfig;
