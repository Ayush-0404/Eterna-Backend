# 🔧 Deployment Troubleshooting Guide

## Issues Identified

1. ❌ Redis connection refused (`ECONNREFUSED`)
2. ❌ Prisma engine missing OpenSSL (`libssl.so.1.1`)

---

## 🔴 Quick Fix for Railway Deployment

### Step 1: Add Redis Service

1. In Railway dashboard, click **"New"**
2. Select **"Database"** → **"Redis"**
3. Wait for it to provision
4. Railway will auto-create `REDIS_URL` variable

### Step 2: Fix Prisma Engine for Alpine Linux

**Add this to your `package.json`:**

```json
{
  "prisma": {
    "schema": "prisma/schema.prisma"
  },
  "engines": {
    "node": ">=20.0.0"
  }
}
```

**Update your Dockerfile** (if using Docker):

```dockerfile
FROM node:20-alpine

# Install OpenSSL for Prisma
RUN apk add --no-cache openssl libc6-compat

WORKDIR /app

COPY package*.json ./
COPY prisma ./prisma/

RUN npm ci --only=production

# Generate Prisma Client
RUN npx prisma generate

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
```

### Step 3: Add Build Command in Railway

Go to your Railway service settings:

**Build Command:**
```bash
npm install && npx prisma generate && npm run build
```

**Start Command:**
```bash
npm start
```

---

## 🟢 Alternative: Use Render.com Instead

Render has better defaults and easier setup:

### Steps:

1. **Go to https://render.com**
2. **Sign in with GitHub**
3. **New → Web Service**
4. **Connect your GitHub repo**: `Ayush-0404/Eterna-Backend`

5. **Configure Service:**
   - **Name**: `order-execution-engine`
   - **Region**: Choose closest to you
   - **Branch**: `master`
   - **Root Directory**: Leave blank
   - **Runtime**: `Node`
   - **Build Command**: 
     ```bash
     npm install && npx prisma generate && npm run build
     ```
   - **Start Command**: 
     ```bash
     npm start
     ```

6. **Add Environment Variables:**
   - `NODE_ENV` = `production`
   - `PORT` = `3000`
   - (DATABASE_URL will be added next)
   - (REDIS_URL will be added next)

7. **Add PostgreSQL:**
   - In Render dashboard, click **"New +"**
   - Select **"PostgreSQL"**
   - Name: `order-execution-engine-db`
   - Click **"Create Database"**
   - Wait for it to provision
   - Copy the **"Internal Database URL"**
   - Go back to your web service
   - Add environment variable: `DATABASE_URL` = (paste URL)

8. **Add Redis (via Upstash):**
   - Go to https://upstash.com
   - Sign up (free)
   - Create Redis database
   - Copy the `UPSTASH_REDIS_REST_URL`
   - Go to Render environment variables
   - Add: `REDIS_URL` = (paste URL)

9. **Deploy:**
   - Click **"Create Web Service"**
   - Wait 3-5 minutes for deployment
   - You'll get a URL like: `https://order-execution-engine.onrender.com`

10. **Run Database Migration:**
    - In Render dashboard, go to your web service
    - Click **"Shell"** tab
    - Run:
      ```bash
      npx prisma migrate deploy
      ```

---

## 🟣 Fix for Current Railway Deployment

If you want to continue with Railway:

### 1. Add Redis
- Dashboard → New → Database → Redis
- Wait for provisioning

### 2. Update Environment Variables
Make sure these are set:
- `DATABASE_URL` (auto from PostgreSQL)
- `REDIS_URL` (auto from Redis)
- `NODE_ENV` = `production`
- `PORT` = `3000`

### 3. Fix Prisma Binary Issue

**Option A: Use build command**
```bash
npm install && npx prisma generate && npm run build
```

**Option B: Add to package.json**
```json
{
  "scripts": {
    "postinstall": "prisma generate",
    "build": "tsc",
    "start": "node dist/index.js"
  }
}
```

### 4. Redeploy
- Push changes to GitHub
- Railway will auto-redeploy

---

## ✅ Verification Steps

Once deployed:

```bash
# Test health endpoint
curl https://your-app.railway.app/health

# Should return:
{"status":"ok","timestamp":"...","uptime":...}
```

---

## 🎯 Recommended: Switch to Render

Railway can be tricky with Prisma. **Render.com** has:
- ✅ Better Prisma support out of the box
- ✅ Free PostgreSQL included
- ✅ Easier environment variable management
- ✅ More stable for Node.js apps
- ✅ 750 hours/month free (enough for demos)

Follow the "Alternative: Use Render.com" steps above.

---

## 📝 Quick Commands Reference

**Test locally first:**
```bash
# Set environment variables
set DATABASE_URL=your_postgres_url
set REDIS_URL=your_redis_url

# Build and run
npm run build
npm start
```

**Check deployment logs:**
- Railway: Dashboard → Your Service → Deployments → View Logs
- Render: Dashboard → Your Service → Logs

---

## 🆘 Still Having Issues?

**Check:**
1. ✅ Redis service is running (green status)
2. ✅ PostgreSQL service is running (green status)
3. ✅ Environment variables are set correctly
4. ✅ Build command includes `prisma generate`
5. ✅ Node version is 20+ in deployment settings

**Common fixes:**
- Clear build cache and redeploy
- Verify `REDIS_URL` format: `redis://...` or `rediss://...`
- Check Railway/Render service logs for detailed errors
