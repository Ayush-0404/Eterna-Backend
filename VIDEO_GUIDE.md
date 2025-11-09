# YouTube Demo Video Guide

## 🎥 Video Requirements (1-2 minutes)

### Required Content Checklist

- [ ] **a. Order flow through system and design decisions** (20-30 seconds)
- [ ] **b. Submit 3-5 orders simultaneously** (20-30 seconds)
- [ ] **c. WebSocket showing status updates** (pending → routing → confirmed) (20-30 seconds)
- [ ] **d. DEX routing decisions in logs/console** (15-20 seconds)
- [ ] **e. Queue processing multiple orders** (15-20 seconds)

---

## 📋 Video Script & Recording Guide

### Scene 1: Introduction (10 seconds)
**Show**: VS Code with README.md open

**Say**: 
> "This is an Order Execution Engine with smart DEX routing, real-time WebSocket updates, and concurrent order processing. Let me show you how it works."

---

### Scene 2: Architecture Overview (20 seconds)
**Show**: README.md scrolled to Architecture diagram

**Say**:
> "The system uses a queue-based architecture with BullMQ for concurrent processing, Redis pub/sub for WebSocket updates, and a factory pattern for order execution. Orders are routed to the best DEX by comparing Raydium and Meteora prices."

---

### Scene 3: Start Server (10 seconds)
**Show**: Terminal running `npm run dev`

**Say**:
> "Starting the server with 10 concurrent workers and rate limiting at 100 orders per minute."

**Show**: Server logs showing:
```
Queue service initialized
WebSocket service initialized
Server started successfully
```

---

### Scene 4: Submit 3-5 Orders Simultaneously (30 seconds)
**Show**: Split screen - Left: Terminal running load test, Right: Server logs

**Run**: 
```bash
npx tsx scripts/load-test.ts
```

**OR** use Postman Collection Runner

**Say**:
> "Now I'm submitting 5 orders simultaneously. Watch the queue distribute them across workers."

**Show**:
- Orders being created
- Queue processing them concurrently
- Success messages

---

### Scene 5: WebSocket Live Updates (30 seconds)
**Show**: Terminal running WebSocket test

**Run**:
```bash
npx tsx scripts/websocket-final-test.ts
```

**Say**:
> "Here's a WebSocket connection showing real-time status updates. You can see the order progressing through pending, routing with DEX comparison, building, submitted, and confirmed states."

**Show**: WebSocket messages appearing in real-time with ~3 second delays:
```json
Message #1: connection:established
Message #2: routing (with Raydium/Meteora quotes)
Message #3: building
Message #4: submitted
Message #5: confirmed
```

---

### Scene 6: DEX Routing Decisions (20 seconds)
**Show**: Server terminal with routing logs visible

**Point to**:
```
DEX Routing Decision
  raydiumPrice: "297.942551"
  meteoraPrice: "294.346478"
  selectedDex: "Raydium"
  priceDifference: "1.22%"
```

**Say**:
> "The DEX router compares prices from both Raydium and Meteora, accounting for fees, and automatically selects the better price. In this case, Raydium offered 1.22% better pricing."

---

### Scene 7: Queue Stats (15 seconds)
**Show**: Postman or browser with `/api/orders/stats` response

**Say**:
> "The stats endpoint shows the queue has processed over 100 orders with zero failures and a 100% success rate."

**Show**:
```json
{
  "queue": {
    "completed": 104,
    "failed": 0,
    "total": 104
  }
}
```

---

### Scene 8: Tests Passing (10 seconds)
**Show**: Terminal running `npm test`

**Say**:
> "The system has 44 passing unit tests and all Postman integration tests pass successfully."

---

### Scene 9: Wrap Up (5 seconds)
**Show**: GitHub repo page

**Say**:
> "Check out the full code, documentation, and Postman collection in the GitHub repository. Thanks for watching!"

---

## 🎬 Recording Tools

### Option 1: OBS Studio (Free, Professional)
- Download: https://obsproject.com/
- Good for multi-window recording
- Can add picture-in-picture

### Option 2: Loom (Easiest, Free tier available)
- Website: https://www.loom.com/
- Great for quick screen recordings
- Automatically uploads to cloud

### Option 3: Windows Game Bar (Built-in Windows)
- Press `Win + G` to start
- Click record button
- Simple and quick

### Option 4: ShareX (Free, Windows)
- Download: https://getsharex.com/
- Lightweight screen recorder

---

## 📝 Video Recording Checklist

**Before Recording:**
- [ ] Close unnecessary tabs/applications
- [ ] Set terminal font size to 14-16pt (readable)
- [ ] Prepare all commands in a script file
- [ ] Test run everything once
- [ ] Make sure server is running
- [ ] Check audio quality

**During Recording:**
- [ ] Speak clearly and at moderate pace
- [ ] Show each feature for at least 5 seconds
- [ ] Point to important parts on screen
- [ ] Keep it under 2 minutes

**After Recording:**
- [ ] Upload to YouTube (unlisted or public)
- [ ] Add title: "Order Execution Engine - DEX Routing & WebSocket Updates"
- [ ] Add description with GitHub link
- [ ] Add timestamps in description
- [ ] Copy YouTube link
- [ ] Add link to README.md

---

## 📺 YouTube Upload Settings

**Title**: 
```
Order Execution Engine - Smart DEX Routing with Real-time WebSocket Updates
```

**Description**:
```
Production-ready Order Execution Engine demonstration

Features:
✅ Smart DEX routing (Raydium vs Meteora price comparison)
✅ Real-time WebSocket status updates
✅ Concurrent queue processing (10 workers)
✅ 44 passing unit tests
✅ 100+ orders processed with 0% failure rate

GitHub: [Add your repo URL]
Live Demo: [Add your deployment URL]

Timestamps:
0:00 - Introduction & Architecture
0:20 - Submitting concurrent orders
0:50 - WebSocket live updates
1:10 - DEX routing decisions
1:30 - Queue statistics & tests

Tech Stack: Node.js, TypeScript, Fastify, BullMQ, Redis, PostgreSQL, WebSocket
```

**Tags**:
```
order execution, dex routing, websocket, typescript, nodejs, solana, raydium, meteora, queue management, real-time updates
```

---

## ✅ Final Steps

1. Record video (aim for 90-120 seconds)
2. Upload to YouTube
3. Set visibility to "Unlisted" or "Public"
4. Copy the YouTube link
5. Add to README.md under "Demo Video" section
6. You're done! 🎉
