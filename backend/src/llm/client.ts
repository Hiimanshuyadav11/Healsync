import { GoogleGenAI } from "@google/genai";

export const ai = new GoogleGenAI({
    apiKey: process.env.GEMINI_API_KEY!,
});

export async function callLLM(system: string, user: string) {
    const model = "gemini-1.5-flash";

    const res = await ai.models.generateContent({
        model: model,
        contents: [
            { role: "user", parts: [{ text: system }] },
            { role: "model", parts: [{ text: "Okay, I understand my instructions." }] },
            { role: "user", parts: [{ text: user }] },
        ],
        config: {
            temperature: 0.2,
        },
    });

    return res.text ?? "";
}
