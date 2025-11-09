# 🎬 Video Recording Checklist

## Before You Start Recording

### 1. Prepare Your Screen
- [ ] Close all unnecessary applications
- [ ] Open VS Code with your project
- [ ] Open PowerShell terminal (clear it with `cls`)
- [ ] Open browser with Railway deployment logs: https://railway.app
- [ ] Set screen resolution to 1920x1080 (if possible)
- [ ] Test your microphone

### 2. Verify Deployment is Running
```powershell
Invoke-RestMethod -Uri "https://eterna-backend-production-38e4.up.railway.app/health"
```
Should return: `status: ok`

### 3. Open Railway Logs
1. Go to https://railway.app
2. Click on your Eterna-Backend project
3. Click on the service
4. Click "Deployments" tab → Latest deployment → "View Logs"
5. Keep this tab visible

---

## Recording Setup Options

### Option A: Windows Game Bar (Easiest - Built-in)
1. Press `Win + G` to open Game Bar
2. Click the record button (or `Win + Alt + R`)
3. To stop: `Win + Alt + R` again
4. Videos saved to: `C:\Users\[YourName]\Videos\Captures`

### Option B: OBS Studio (Professional - Free)
1. Download: https://obsproject.com/
2. Install and open OBS
3. Click "+" under Sources → "Display Capture"
4. Click "Start Recording"
5. To stop: Click "Stop Recording"

---

## What to Record (90 seconds total)

### Scene 1: Introduction (10 sec)
**Show:** README.md in VS Code
**Say:** 
> "This is my Order Execution Engine for Solana DEX trading with market orders, DEX routing, WebSocket updates, and queue processing."

---

### Scene 2: Run the Demo Script (60 sec)

**In PowerShell, run:**
```powershell
.\scripts\demo-video.ps1
```

**While it runs, say:**
> "I'm submitting 5 concurrent orders with different token pairs. Watch the Railway logs on the left showing DEX routing decisions - the system automatically selects Raydium or Meteora based on best pricing. You can see order statuses transitioning from pending to routing, building, submitted, and confirmed. The queue processes all orders concurrently with zero failures."

**Point out on screen:**
- Orders being created in terminal (right side)
- Railway logs showing DEX routing (left side)
- Status transitions in logs
- Queue statistics at the end

---

### Scene 3: Highlight Results (20 sec)
**Show:** Queue statistics in terminal + Railway logs

**Say:**
> "All 5 orders completed successfully with 100% success rate. The system has 44 passing unit tests, handles 113,000 orders per minute, and maintains concurrent processing with WebSocket live updates."

**Optional:** Briefly scroll through TEST_RESULTS.md or show architecture diagram

---

## Recording Flow

### Before Recording:
1. Clear terminal: `cls`
2. Position windows side-by-side:
   - Left: Browser with Railway logs
   - Right: VS Code with terminal

### During Recording (90 seconds):
1. [0:00-0:10] Show README, introduce project
2. [0:10-0:70] Run `.\scripts\demo-video.ps1`, narrate while watching logs
3. [0:70-0:90] Point to final stats, mention test results

### After Recording:
1. Stop recording
2. Watch the video to check quality
3. Re-record if needed (it's okay!)

---

## What You MUST Show (Required)

✅ **3-5 orders submitted simultaneously** → Demo script does 5  
✅ **WebSocket status updates** → Visible in Railway logs  
✅ **DEX routing decisions** → Logs show "Selected DEX: Raydium/Meteora"  
✅ **Queue processing** → Terminal shows stats with active/completed orders  

---

## Sample Narration Script

```
[0:00-0:10] Introduction
"Hi! This is my Order Execution Engine for Solana. It features market order execution, 
intelligent DEX routing between Raydium and Meteora, real-time WebSocket updates, 
and concurrent queue processing."

[0:10-0:15] Start Demo
"Let me demonstrate by submitting 5 concurrent orders."

[0:15-0:30] While Orders Submit
"You can see in the terminal - 5 orders with different token pairs: SOL to USDC, 
BONK to SOL, and others. Each order gets a unique ID and enters the queue immediately."

[0:30-0:50] Point to Railway Logs
"On the Railway logs, watch the DEX routing in action. The system compares Raydium 
and Meteora prices for each order and automatically selects the best DEX. See here - 
this order chose Raydium, this one Meteora. Every order goes through the full lifecycle: 
pending, routing, building the transaction, submitted, and confirmed."

[0:50-0:70] Show Queue Processing
"The queue system processes all orders concurrently with 10 workers. You can see 
multiple orders being processed at the same time with status updates streaming 
via WebSocket to any connected clients."

[0:70-0:90] Wrap Up
"Final stats show all 5 orders completed successfully - zero failures, 100% success rate. 
The system has 44 passing unit tests, 8 Postman integration tests, and can handle over 
100,000 orders per minute. Everything is deployed on Railway and open source on GitHub."
```

---

## After Recording

### 1. Review Your Video
- [ ] Audio is clear
- [ ] All 5 orders visible
- [ ] Railway logs showing DEX routing
- [ ] Queue stats visible
- [ ] Duration is 1-2 minutes

### 2. Upload to YouTube
- [ ] Go to https://youtube.com/upload
- [ ] Upload your video
- [ ] Set title: "Order Execution Engine - Solana DEX Trading Demo"
- [ ] Set visibility: **Unlisted** (or Public)
- [ ] Copy the YouTube link

### 3. Update Your README
```powershell
# Edit README.md and add YouTube link
# Then commit and push
git add README.md FINAL_SUBMISSION.md
git commit -m "docs: Add YouTube demo video link"
git push origin master
```

---

## Quick Test Run (Before Recording)

Practice once without recording:

```powershell
# Test the demo script
.\scripts\demo-video.ps1

# Check Railway logs are visible
# Practice your narration
# Adjust window positions
```

---

## Tips for Great Video

✅ **Speak clearly** - Don't rush, pause between sections  
✅ **Point to things** - Use your cursor to highlight important parts  
✅ **Show enthusiasm** - You built something cool!  
✅ **Don't worry about perfection** - Natural is better than perfect  
✅ **Keep it concise** - 90 seconds is plenty  

---

## You're Ready! 🚀

When you're comfortable with the setup:
1. Start recording
2. Run the demo script
3. Narrate what's happening
4. Stop recording
5. Upload to YouTube
6. Add link to README

**Good luck! You've got this! 🎬**
