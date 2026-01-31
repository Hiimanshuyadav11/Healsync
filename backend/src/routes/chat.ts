import express from "express";
import { runPipeline } from "../orchestrator/pipeline";

const router = express.Router();

router.post("/chat", async (req, res) => {
    try {
        const { message, userId } = req.body;
        const effectiveUserId = userId || "default_user";
        const reply = await runPipeline(effectiveUserId, message);
        res.json({ reply });
    } catch (e: any) {
        console.error("Chat Error:", e);
        res.json({ reply: `System Error: ${e.message || "Unknown error"}` });
    }
});

export default router;
