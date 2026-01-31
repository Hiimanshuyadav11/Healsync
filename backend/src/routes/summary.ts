import express from "express";
import { generateDoctorSummary } from "../health/summaryGenerator";
import { getLastJournals } from "../memory/journalstore";

const router = express.Router();

router.get("/summary/:userId", async (req, res) => {
    const data = getLastJournals(req.params.userId, 20);
    const summary = await generateDoctorSummary(data);
    res.json({ summary });
});

export default router;
