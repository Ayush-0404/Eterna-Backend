# Deployment Guide - Free Hosting Options

## 🚀 Recommended: Railway.app (Easiest for Full Stack)

### Why Railway?
- ✅ Free tier with $5 credit/month
- ✅ Supports PostgreSQL + Redis out of the box
- ✅ Auto-deploys from GitHub
- ✅ No credit card required for trial

### Steps:

**1. Sign up at https://railway.app**
- Use GitHub login

**2. Create New Project**
- Click "New Project"
- Select "Deploy from GitHub repo"
- Choose your `order-execution-engine` repository

**3. Add PostgreSQL Database**
- In your project, click "New"
- Select "Database" → "PostgreSQL"
- Railway will provision it automatically

**4. Add Redis**
- Click "New" again
- Select "Database" → "Redis"

**5. Configure Environment Variables**
- Click on your app service
- Go to "Variables" tab
- Add these (Railway auto-provides DATABASE_URL and REDIS_URL):
  ```
  NODE_ENV=production
  PORT=3000
  DATABASE_URL=${{Postgres.DATABASE_URL}}  # Auto-filled by Railway
  REDIS_URL=${{Redis.REDIS_URL}}            # Auto-filled by Railway
  QUEUE_CONCURRENCY=10
  QUEUE_RATE_LIMIT=100
  ```

**6. Deploy**
- Railway auto-deploys when you push to GitHub
- Get your public URL from the "Settings" → "Networking" → "Generate Domain"

**7. Run Database Migrations**
- In Railway dashboard, click on your app
- Go to "Deployments" → "View Logs"
- Or run in local terminal:
  ```bash
  npx prisma migrate deploy --schema=./prisma/schema.prisma
  ```

**8. Test Your Deployment**
- Your URL will be: `https://your-app.up.railway.app`
- Test: `https://your-app.up.railway.app/health`

---

## 🔵 Alternative 1: Render.com

### Steps:
1. Sign up at https://render.com
2. Create "Web Service" from GitHub repo
3. Build Command: `npm install && npm run build && npx prisma generate`
4. Start Command: `npm start`
5. Add PostgreSQL (Free tier) from Render dashboard
6. Add Redis via Upstash.com (free tier)
7. Set environment variables
8. Deploy!

---

## 🟢 Alternative 2: Fly.io

### Steps:
1. Install Fly CLI: https://fly.io/docs/hands-on/install-flyctl/
2. Sign up: `flyctl auth signup`
3. Launch app:
   ```bash
   flyctl launch
   ```
4. Add PostgreSQL:
   ```bash
   flyctl postgres create
   ```
5. Add Upstash Redis:
   - Go to https://upstash.com
   - Create free Redis database
   - Copy connection URL
6. Set secrets:
   ```bash
   flyctl secrets set DATABASE_URL=your_postgres_url
   flyctl secrets set REDIS_URL=your_redis_url
   ```
7. Deploy:
   ```bash
   flyctl deploy
   ```

---

## 🟣 Alternative 3: Vercel (API Routes Only)

**Note**: Vercel is serverless, so the queue worker won't run continuously. Not recommended for this project since it requires persistent workers.

---

## ✅ Post-Deployment Checklist

After deployment:

- [ ] Health endpoint works: `GET /health`
- [ ] Can create order: `POST /api/orders/execute`
- [ ] Database connection successful
- [ ] Redis connection successful
- [ ] Queue worker running
- [ ] WebSocket connections work
- [ ] Add public URL to README.md
- [ ] Test with Postman collection

---

## 🔗 Update Your README

Once deployed, update README.md with:

```markdown
## 🔴 Live Demo

**Public URL**: https://your-app.railway.app

**Test the API**:
- Health Check: https://your-app.railway.app/health
- API Info: https://your-app.railway.app/
- Stats: https://your-app.railway.app/api/orders/stats
```

---

## 📝 Notes

- Free tiers have limitations (sleep after inactivity, limited resources)
- For production, consider upgrading or using dedicated hosting
- Monitor your usage to avoid unexpected charges
- Railway gives $5/month free, usually enough for testing/demos
