import express from "express";
import { detectDistortion } from "../cbt/distortionDetector";
import { saveJournal } from "../memory/journalstore";

const router = express.Router();

router.post("/journal", async (req, res) => {
    const { userId, text } = req.body;
    const analysis = await detectDistortion(text);

    saveJournal({ userId, text, ...analysis, createdAt: Date.now() });

    res.json({ ok: true, analysis });
});

export default router;
