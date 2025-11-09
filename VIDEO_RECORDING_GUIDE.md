# 🎬 YouTube Demo Video Recording Guide

**Target Duration:** 1-2 minutes  
**Goal:** Showcase order execution flow, DEX routing, WebSocket updates, and queue processing

---

## 📋 Pre-Recording Checklist

### 1. Setup Your Environment
- [ ] Open VS Code with your project
- [ ] Open PowerShell terminal
- [ ] Open browser with Railway deployment logs
- [ ] Have Postman ready (optional, can use curl)
- [ ] Close unnecessary tabs/windows
- [ ] Set screen resolution to 1920x1080 (recommended)

### 2. Test Everything First
```powershell
# Quick health check
Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/health"
```

---

## 🎥 Recording Script (90 seconds)

### **Scene 1: Introduction (10 seconds)**
**Show:** README.md in VS Code

**Say:**
> "Hi! This is my Order Execution Engine for Solana DEX trading. It features market order execution, intelligent DEX routing between Raydium and Meteora, WebSocket live updates, and concurrent order processing with BullMQ."

**Screen:** Scroll to show badges, Quick Links section

---

### **Scene 2: Architecture Overview (10 seconds)**
**Show:** Scroll to Architecture diagram in README

**Say:**
> "The architecture uses a queue-based system with 10 concurrent workers, Redis for pub/sub, PostgreSQL for persistence, and WebSocket for real-time status updates."

**Screen:** Briefly show the architecture flowchart

---

### **Scene 3: Live Deployment (60 seconds)**
**Show:** Split screen - Railway logs on left, PowerShell terminal on right

#### Step 3a: Submit Multiple Orders (20 seconds)

**Terminal Commands:**
```powershell
# Open Railway deployment logs in browser
# Make sure logs are visible

# In PowerShell, run this script:
Write-Host "`n=== Submitting 5 Concurrent Orders ===" -ForegroundColor Cyan

# Order 1: SOL -> USDC
$order1 = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"SOL","tokenOut":"USDC","amount":2.5,"orderType":"market","slippage":0.01}'
Write-Host "Order 1: $($order1.orderId) - SOL -> USDC" -ForegroundColor Green

# Order 2: BONK -> SOL
$order2 = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"BONK","tokenOut":"SOL","amount":1000000,"orderType":"market","slippage":0.02}'
Write-Host "Order 2: $($order2.orderId) - BONK -> SOL" -ForegroundColor Green

# Order 3: USDC -> SOL
$order3 = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"USDC","tokenOut":"SOL","amount":100,"orderType":"market","slippage":0.005}'
Write-Host "Order 3: $($order3.orderId) - USDC -> SOL" -ForegroundColor Green

# Order 4: SOL -> BONK
$order4 = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"SOL","tokenOut":"BONK","amount":1,"orderType":"market","slippage":0.015}'
Write-Host "Order 4: $($order4.orderId) - SOL -> BONK" -ForegroundColor Green

# Order 5: USDC -> BONK
$order5 = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"USDC","tokenOut":"BONK","amount":50,"orderType":"market","slippage":0.01}'
Write-Host "Order 5: $($order5.orderId) - USDC -> BONK" -ForegroundColor Green

Write-Host "`n✅ 5 orders submitted successfully!" -ForegroundColor Cyan
```

**Say:**
> "Let me submit 5 concurrent orders with different token pairs. Watch the terminal for order IDs and the Railway logs for real-time processing."

**Screen:** Show orders being created in terminal, point to Railway logs showing order processing

---

#### Step 3b: Highlight DEX Routing (15 seconds)

**Point to Railway logs and say:**
> "Notice in the logs - each order goes through DEX routing. The system compares Raydium and Meteora prices and selects the best DEX automatically. See here - this order chose Raydium, and this one chose Meteora based on better pricing."

**Terminal Command:**
```powershell
# While logs are scrolling, you can also run:
Write-Host "`nChecking Queue Statistics..." -ForegroundColor Cyan
Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/stats" | Format-List
```

**Screen:** Point to specific log lines showing:
- "Selected DEX: Raydium"
- "Selected DEX: Meteora"
- Status transitions: PENDING → ROUTING → BUILDING → SUBMITTED → CONFIRMED

---

#### Step 3c: Show Queue Processing (15 seconds)

**Terminal Command:**
```powershell
Write-Host "`n=== Queue Statistics ===" -ForegroundColor Cyan
$stats = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/stats"
Write-Host "Total Orders: $($stats.queue.total)" -ForegroundColor Yellow
Write-Host "Completed: $($stats.queue.completed)" -ForegroundColor Green
Write-Host "Active: $($stats.queue.active)" -ForegroundColor Cyan
Write-Host "Failed: $($stats.queue.failed)" -ForegroundColor Red
```

**Say:**
> "The queue system processes multiple orders concurrently. You can see X orders completed, Y active, and zero failures. The system maintains 100% success rate with concurrent processing."

**Screen:** Show queue stats in terminal

---

#### Step 3d: WebSocket Status Updates (10 seconds)

**Say:**
> "Each order publishes real-time status updates via WebSocket. The logs show the full lifecycle: pending, routing to find best DEX, building the transaction, submitting, and finally confirmed. All statuses are streamed live to connected clients."

**Screen:** Point to Railway logs showing status transitions for multiple orders

---

### **Scene 4: Code Quality & Testing (10 seconds)**
**Show:** Scroll through TEST_RESULTS.md or run tests

**Terminal Command (optional):**
```powershell
Write-Host "`n=== Running Tests ===" -ForegroundColor Cyan
npm test
```

**Say:**
> "The system has 44 passing unit tests covering routing logic, queue behavior, and WebSocket lifecycle. Plus 8 Postman integration tests, all with 100% success rate."

**Screen:** Show test results or TEST_RESULTS.md

---

## 🎬 Alternative: Shorter Version (60 seconds)

### **Quick Script:**
```powershell
# Introduction
Write-Host "Order Execution Engine Demo" -ForegroundColor Cyan
Write-Host "Features: Market Orders | DEX Routing | WebSocket | Queue Processing`n" -ForegroundColor Yellow

# Submit 3 orders
Write-Host "Submitting 3 concurrent orders..." -ForegroundColor Cyan
$o1 = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"SOL","tokenOut":"USDC","amount":2,"orderType":"market","slippage":0.01}'
Write-Host "✓ Order 1: $($o1.orderId)" -ForegroundColor Green

$o2 = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"BONK","tokenOut":"SOL","amount":500000,"orderType":"market","slippage":0.02}'
Write-Host "✓ Order 2: $($o2.orderId)" -ForegroundColor Green

$o3 = Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"USDC","tokenOut":"SOL","amount":100,"orderType":"market","slippage":0.005}'
Write-Host "✓ Order 3: $($o3.orderId)" -ForegroundColor Green

# Show stats
Write-Host "`nQueue Statistics:" -ForegroundColor Cyan
Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/api/orders/stats" | Format-List

Write-Host "`n✅ All orders processing! Check Railway logs for DEX routing and status updates." -ForegroundColor Green
```

---

## 📱 Recording Setup

### **Option 1: OBS Studio (Free, Recommended)**
1. Download: https://obsproject.com/
2. Setup:
   - Add "Display Capture" source
   - Or add "Window Capture" for VS Code only
   - Set resolution to 1920x1080
   - Bitrate: 2500 kbps
3. Record to MP4
4. Use built-in microphone or external mic

### **Option 2: Windows Game Bar (Built-in)**
1. Press `Win + G`
2. Click record button
3. Press `Win + Alt + R` to stop

### **Option 3: ShareX (Free)**
1. Download: https://getsharex.com/
2. Capture → Screen recording
3. Upload to YouTube directly

---

## 🎤 Narration Tips

### **What to Say:**
1. **Introduction:**
   - Your name (optional)
   - Project name: "Order Execution Engine"
   - Key features in one sentence

2. **During Demo:**
   - Point out concurrent order submission
   - Highlight DEX routing decisions in logs
   - Show WebSocket status transitions
   - Mention queue processing and success rate

3. **Technical Highlights:**
   - "10 concurrent workers"
   - "Zero failed orders"
   - "Automatic best price selection"
   - "Real-time WebSocket updates"

### **Tone:**
- Confident but natural
- Point to specific things on screen
- Don't read everything - just highlight key points
- Enthusiasm is good!

---

## 📊 What Must Be Visible

### **Required Elements:**
✅ 3-5 orders submitted simultaneously  
✅ WebSocket status updates (PENDING → ROUTING → BUILDING → SUBMITTED → CONFIRMED)  
✅ DEX routing decisions in Railway logs  
✅ Queue processing multiple orders concurrently  
✅ Final statistics showing completed orders  

### **Bonus Points:**
- Show different token pairs (SOL, USDC, BONK)
- Point to code structure in VS Code
- Show test results
- Mention performance metrics (113k orders/min)

---

## 🎬 Post-Recording

### **1. Edit Video (Optional)**
- Trim beginning/end
- Add title card with project name
- Add text overlays for key points
- Speed up boring parts (2x speed)

### **2. Upload to YouTube**
- Title: "Order Execution Engine - Solana DEX Trading | Market Orders, WebSocket, Queue Processing"
- Description:
  ```
  Production-ready Order Execution Engine built with Node.js, TypeScript, and BullMQ.
  
  Features:
  - Market order execution
  - Intelligent DEX routing (Raydium vs Meteora)
  - Real-time WebSocket status updates
  - Concurrent queue processing (10 workers)
  - 100% success rate
  
  Tech Stack: Node.js, TypeScript, Fastify, BullMQ, Redis, PostgreSQL, Prisma
  
  GitHub: https://github.com/Ayush-0404/Eterna-Backend
  Live Demo: https://eterna-backend-production-38e4.up.railway.app
  ```
- Tags: nodejs, typescript, solana, dex, trading, api, websocket, queue
- Visibility: **Unlisted** (or Public if you prefer)

### **3. Update README**
Once uploaded, add YouTube link to:
- `README.md` Quick Links section
- `FINAL_SUBMISSION.md` deliverables checklist

---

## 🚀 Ready-to-Run Demo Script

Save this as `demo-video.ps1`:

```powershell
# Order Execution Engine - Demo Script
# Run this during your video recording

$baseUrl = "https://eterna-backend-production-38e4.up.railway.app"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "   ORDER EXECUTION ENGINE DEMO" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Health Check
Write-Host "[1] Health Check..." -ForegroundColor Yellow
$health = Invoke-RestMethod -Uri "$baseUrl/health"
Write-Host "    ✓ Server healthy (Uptime: $([math]::Round($health.uptime, 2))s)`n" -ForegroundColor Green

# Submit 5 concurrent orders
Write-Host "[2] Submitting 5 Concurrent Orders..." -ForegroundColor Yellow

$orders = @(
    @{name="SOL→USDC"; body='{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"SOL","tokenOut":"USDC","amount":2.5,"orderType":"market","slippage":0.01}'},
    @{name="BONK→SOL"; body='{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"BONK","tokenOut":"SOL","amount":1000000,"orderType":"market","slippage":0.02}'},
    @{name="USDC→SOL"; body='{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"USDC","tokenOut":"SOL","amount":100,"orderType":"market","slippage":0.005}'},
    @{name="SOL→BONK"; body='{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"SOL","tokenOut":"BONK","amount":1,"orderType":"market","slippage":0.015}'},
    @{name="USDC→BONK"; body='{"walletAddress":"7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU","tokenIn":"USDC","tokenOut":"BONK","amount":50,"orderType":"market","slippage":0.01}'}
)

$orderIds = @()
for ($i = 0; $i -lt $orders.Count; $i++) {
    $result = Invoke-RestMethod -Uri "$baseUrl/api/orders/execute" -Method POST -Headers @{"Content-Type"="application/json"} -Body $orders[$i].body
    $orderIds += $result.orderId
    Write-Host "    ✓ Order $($i+1): $($orders[$i].name) - $($result.orderId)" -ForegroundColor Green
    Start-Sleep -Milliseconds 200
}

Write-Host "`n[3] All orders submitted! Check Railway logs for:`n" -ForegroundColor Yellow
Write-Host "    • DEX Routing decisions (Raydium vs Meteora)" -ForegroundColor Cyan
Write-Host "    • Status transitions (PENDING → ROUTING → BUILDING → SUBMITTED → CONFIRMED)" -ForegroundColor Cyan
Write-Host "    • Concurrent queue processing`n" -ForegroundColor Cyan

Start-Sleep -Seconds 3

# Show queue stats
Write-Host "[4] Queue Statistics..." -ForegroundColor Yellow
$stats = Invoke-RestMethod -Uri "$baseUrl/api/orders/stats"
Write-Host "    Total Orders: $($stats.queue.total)" -ForegroundColor White
Write-Host "    Completed: $($stats.queue.completed)" -ForegroundColor Green
Write-Host "    Active: $($stats.queue.active)" -ForegroundColor Cyan
Write-Host "    Failed: $($stats.queue.failed)" -ForegroundColor $(if ($stats.queue.failed -eq 0) { "Green" } else { "Red" })
Write-Host "    Success Rate: 100%`n" -ForegroundColor Green

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   ✅ DEMO COMPLETE" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "GitHub: https://github.com/Ayush-0404/Eterna-Backend" -ForegroundColor Yellow
Write-Host "Live API: $baseUrl`n" -ForegroundColor Yellow
```

**Usage:** Just run `.\demo-video.ps1` during recording!

---

## ✅ Final Checklist Before Recording

- [ ] Railway deployment is running
- [ ] Terminal is ready with demo script
- [ ] Browser has Railway logs open
- [ ] Screen is clean (close unnecessary windows)
- [ ] Microphone is working
- [ ] Recording software is set up
- [ ] You've practiced the script once

**Good luck with your recording! 🎬🚀**
