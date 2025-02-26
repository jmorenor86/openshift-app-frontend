import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL || "https://application-a1.1sdff4t8daw0.private.eu-de.codeengine.appdomain.cloud",
  },
};

export default nextConfig;
