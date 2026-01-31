import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import { connectDB } from "./config";
dotenv.config();
import { ensureCollection } from "./rag/qdrant";
connectDB();
ensureCollection();

import chatRoute from "./routes/chat";
import authRoute from "./routes/auth";
import uploadRoute from "./routes/upload";
import wearableRoute from "./routes/wearable";

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api", chatRoute);
app.use("/api/auth", authRoute);
app.use("/api", uploadRoute);
app.use("/api", wearableRoute);

app.use("/api", wearableRoute);

// Global Error Handler for JSON response
app.use((err: any, req: express.Request, res: express.Response, next: express.NextFunction) => {
    console.error(err);
    res.status(500).json({ error: err.message || "Internal Server Error" });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`HealSync backend running on http://localhost:${PORT}`);
});
