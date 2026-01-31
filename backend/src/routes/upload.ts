import multer from "multer";
const pdf = require("pdf-parse");
import express from "express";
import { getEmbedding } from "../llm/embeddings";
import { qdrant } from "../rag/qdrant";
import { splitText } from "../utils/textSplitter";

const upload = multer();
const router = express.Router();

router.post("/upload", upload.single("file"), async (req, res) => {
    try {
        const data = await pdf(req.file!.buffer);
        const userId = req.body.userId || "default_user";

        // Chunk the text
        const chunks = await splitText(data.text);
        console.log(`Splitting document into ${chunks.length} chunks for user ${userId}`);

        const points = [];

        for (let i = 0; i < chunks.length; i++) {
            const chunk = chunks[i];
            const vector = await getEmbedding(chunk);
            points.push({
                id: Date.now() + i, // Simple unique ID generation
                vector,
                payload: {
                    text: chunk,
                    type: "report",
                    userId,
                    chunkIndex: i,
                    totalChunks: chunks.length,
                    originalLength: data.text.length
                }
            });
        }

        if (points.length > 0) {
            await qdrant.upsert(process.env.QDRANT_COLLECTION!, {
                points
            });
        }

        res.json({ status: "indexed", userId, chunks: chunks.length });
    } catch (e) {
        console.error(e);
        res.status(500).json({ error: "Failed to process document" });
    }
});

export default router;
