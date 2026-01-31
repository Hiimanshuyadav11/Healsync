import express from "express";
import { simulateWearable } from "../health/wearableSimulator";
import { HealthRecord } from "../models/HealthRecord";

const router = express.Router();

router.post("/wearable", async (req, res) => {
    const data = simulateWearable();
    await HealthRecord.create({
        userId: req.body.userId,
        type: "wearable",
        data
    });
    res.json(data);
});

export default router;
