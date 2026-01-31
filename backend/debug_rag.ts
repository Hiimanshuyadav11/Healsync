import dotenv from "dotenv";
dotenv.config();
import { retrieve } from "./src/rag/retriever";
import { getEmbedding } from "./src/llm/embeddings";
import { ensureCollection } from "./src/rag/qdrant";

async function test() {
    await ensureCollection();
    console.log("Testing Embeddings...");
    try {
        const vec = await getEmbedding("test");
        console.log("Embeddings OK, length:", vec.length);
    } catch (e) {
        console.error("Embeddings FAILED:", e);
    }

    console.log("Testing Retrieval...");
    try {
        const docs = await retrieve("fatigue", "default_user");
        console.log("Retrieval Result:", JSON.stringify(docs, null, 2));
    } catch (e) {
        console.error("Retrieval FAILED:", e);
    }
}

test();
