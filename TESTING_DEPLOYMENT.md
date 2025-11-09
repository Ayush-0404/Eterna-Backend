#  Deployment Testing Guide

##  Fixes ( you can look into this doc if any error occur while testing )

### 1. **Database Migration** (Auto-runs on startup)

**What it does:**
```
npx prisma migrate deploy
```
This command:
- Connects to your Railway PostgreSQL database
- Creates the `Order` table (if it doesn't exist)
- Applies any schema changes from `prisma/schema.prisma`

**Why it's needed:**
- Fresh Railway PostgreSQL = empty database (no tables)
- Without migration → App crashes when saving orders
- With migration → Database ready to store orders

**Now automatic:**
Updated `package.json` start script:
```json
"start": "npx prisma migrate deploy && node dist/index.js"
```
Every time Railway starts your app, it runs migration first!

---

##  Testing Your Deployed App

### **Step 1: Get Your Railway URL**

1. Go to Railway dashboard
2. Click on your service (Eterna-Backend)
3. Go to **"Settings"** tab
4. Scroll to **"Networking"** section
5. Click **"Generate Domain"** (if not already done)
6. Copy your URL (e.g., `https://eterna-backend-production.up.railway.app`)

---

### **Step 2: Test Health Endpoint** 

**Why test this first?**
- Verifies server is running
- Checks database connection
- Confirms Redis connection

**How to test:**

**Option A: Browser**
```
Open in browser:
https://your-railway-url.up.railway.app/health
```

**Option B: PowerShell/CMD**
```bash
curl https://your-railway-url.up.railway.app/health
```

**Expected Response:**
```json
{
  "status": "ok",
  "timestamp": "2025-11-09T08:00:00.000Z",
  "uptime": 123.456
}
```

**If it fails:**
- Check Railway logs for errors
- Verify Redis is added and running
- Verify PostgreSQL is running
- Check environment variables

---

### **Step 3: Test API Info Endpoint** ✅

**URL:**
```
https://your-railway-url.up.railway.app/
```

**Expected Response:**
```json
{
  "name": "Order Execution Engine",
  "version": "1.0.0",
  "endpoints": {
    "health": "/health",
    "executeOrder": "POST /api/orders/execute"
  }
}
```

---

### **Step 4: Test Order Creation** 🎯

**Why test this?**
- Verifies database migration worked
- Tests queue system
- Tests DEX routing
- Tests WebSocket pub/sub

**How to test:**

**Option A: PowerShell/CMD**
```bash
curl -X POST https://your-railway-url.up.railway.app/api/orders/execute ^
  -H "Content-Type: application/json" ^
  -d "{\"tokenIn\":\"SOL\",\"tokenOut\":\"USDC\",\"amount\":1.5,\"slippage\":0.01}"
```

**Option B: Postman**
1. Open your Postman collection
2. Find "Execute Market Order - SOL to USDC"
3. Update the URL to your Railway URL:
   ```
   https://your-railway-url.up.railway.app/api/orders/execute
   ```
4. Click **Send**

**Expected Response:**
```json
{
  "orderId": "ord_1762628117342_o77tcmd",
  "status": "pending",
  "timestamp": "2025-11-09T08:00:00.000Z",
  "message": "Order created successfully. Connect to WebSocket for real-time updates.",
  "websocket": "ws://your-railway-url.up.railway.app/api/orders/ord_XXX/stream"
}
```

**If it fails with "table does not exist":**
- Migration didn't run
- Check Railway logs for migration errors
- Manually trigger: See troubleshooting below

---

### **Step 5: Test Queue Statistics** 📊

**URL:**
```
https://your-railway-url.up.railway.app/api/orders/stats
```

**Expected Response:**
```json
{
  "queue": {
    "waiting": 0,
    "active": 0,
    "completed": 1,
    "failed": 0,
    "delayed": 0,
    "total": 1
  },
  "websocket": {
    "connections": 0
  },
  "timestamp": "2025-11-09T08:00:00.000Z"
}
```

**What this shows:**
- `completed`: Number of successfully processed orders
- `failed`: Number of failed orders (should be 0)
- `total`: Total orders submitted

---

### **Step 6: Update Postman Collection** 🔄

**Update baseUrl variable:**

1. Open Postman
2. Click on your collection
3. Go to **Variables** tab
4. Update `baseUrl`:
   - **Initial Value**: `https://your-railway-url.up.railway.app`
   - **Current Value**: `https://your-railway-url.up.railway.app`
5. Save

**Now run all tests:**
- Click collection → Run
- All 8 tests should pass!

---

## 📺 For Your YouTube Video

### **Testing Demo Sequence:**

**1. Show Health Endpoint (5 seconds)**
```
Browser: https://your-url.railway.app/health
Show: {"status":"ok"...}
```

**2. Submit 3 Orders via Postman (15 seconds)**
```
Use Postman Collection Runner
Show: 3 orders being submitted
Show: Responses with order IDs
```

**3. Show Railway Logs (20 seconds)**
```
Railway Dashboard → Your Service → Logs
Point to:
- DEX routing decisions
- "Raydium vs Meteora" price comparison
- Queue processing
- Order completion
```

**4. Show Queue Stats (10 seconds)**
```
Browser: https://your-url.railway.app/api/orders/stats
Show: completed count = 3
```

---

## 🔍 How to Check Railway Logs

**Where to find logs:**
1. Railway Dashboard
2. Click on your service
3. Click **"Deployments"** tab
4. Click on latest deployment
5. Logs appear automatically

**Or use live logs:**
1. Click **"View Logs"** button
2. Logs stream in real-time

**What to look for:**
```
✅ Good signs:
[INFO] Queue service initialized
[INFO] Server started successfully
[INFO] DEX Routing Decision
[INFO] Order processed successfully

❌ Bad signs:
[ERROR] Redis client error
[ERROR] Unable to require Prisma
[ERROR] Table does not exist
```

---

## 🆘 Troubleshooting

### **Issue: "Table Order does not exist"**

**Cause:** Migration didn't run

**Fix:**
```bash
# Option 1: Redeploy (will auto-run migration)
git commit --allow-empty -m "trigger redeploy"
git push origin master

# Option 2: Manual migration (if Railway has console access)
# Railway Dashboard → Service → Shell/Console
npx prisma migrate deploy
```

---

### **Issue: "ECONNREFUSED" Redis errors**

**Cause:** Redis not added or not connected

**Fix:**
1. Verify Redis service exists in Railway
2. Check it's running (green status)
3. Verify `REDIS_URL` environment variable exists

---

### **Issue: Health endpoint returns 503 or errors**

**Cause:** Server crashed or not fully started

**Fix:**
1. Check Railway logs for errors
2. Look for the root cause in logs
3. Common issues:
   - Missing environment variables
   - Database connection failed
   - Redis connection failed

---

## ✅ Deployment Success Checklist

- [ ] Health endpoint returns `{"status":"ok"}`
- [ ] API info endpoint returns app details
- [ ] Can create orders successfully
- [ ] Queue stats show completed orders
- [ ] Railway logs show no errors
- [ ] DEX routing appears in logs
- [ ] Database has Order table (migration worked)
- [ ] Postman collection works with deployed URL

---

## 🎯 Testing Commands Summary

```bash
# Replace YOUR_URL with your Railway URL

# 1. Health Check
curl https://YOUR_URL.up.railway.app/health

# 2. API Info
curl https://YOUR_URL.up.railway.app/

# 3. Submit Order
curl -X POST https://YOUR_URL.up.railway.app/api/orders/execute ^
  -H "Content-Type: application/json" ^
  -d "{\"tokenIn\":\"SOL\",\"tokenOut\":\"USDC\",\"amount\":1.5,\"slippage\":0.01}"

# 4. Get Stats
curl https://YOUR_URL.up.railway.app/api/orders/stats
```

---

## 📝 Add to README.md

Once deployment works, add this to your README:

```markdown
## 🔴 Live Demo

**Deployed URL**: https://your-url.up.railway.app

### Quick Test:
- **Health Check**: https://your-url.up.railway.app/health
- **API Info**: https://your-url.up.railway.app/
- **Stats**: https://your-url.up.railway.app/api/orders/stats

### Try It:
```bash
curl -X POST https://your-url.up.railway.app/api/orders/execute \
  -H "Content-Type: application/json" \
  -d '{"tokenIn":"SOL","tokenOut":"USDC","amount":1.5,"slippage":0.01}'
```
```

---

**Next: Push your updated package.json and test!**

```bash
git add package.json
git commit -m "feat: Auto-run database migrations on startup"
git push origin master
```

Then wait 3-5 minutes for Railway to redeploy and test the health endpoint!
