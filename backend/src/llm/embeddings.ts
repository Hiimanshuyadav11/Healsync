import { GoogleGenAI } from "@google/genai";

// Use GEMINI_API_KEY as established in client.ts and .env
const apiKey = process.env.GEMINI_API_KEY || process.env.GOOGLE_API_KEY;

export const ai = new GoogleGenAI({
    apiKey: apiKey!,
});

export async function getEmbedding(text: string) {
    const res = await ai.models.embedContent({
        model: "text-embedding-004", // Using a valid embedding model
        contents: text,
    });

    const response = res as any;
    // Check if response.embedding exists and has values
    const values = response.embedding?.values || response.embeddings?.[0]?.values;

    if (!values) {
        console.error("Embedding generation failed or returned invalid format", res);
        throw new Error("Failed to generate embedding");
    }

    return values;
}