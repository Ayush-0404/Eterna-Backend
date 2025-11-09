#!/bin/sh
set -e

echo "🔄 Running Prisma migrations..."
npx prisma migrate deploy

echo "✅ Migrations completed successfully"
echo "🚀 Starting application..."

# Switch to nodejs user and start the application
su-exec nodejs node dist/index.js
