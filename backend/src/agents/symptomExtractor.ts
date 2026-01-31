import { callLLM } from "../llm/client";

const SYSTEM = `
Extract structured information from the user's message.

Return JSON:
{
  "age": null | number,
  "gender": null | "male" | "female" | "other",
  "symptoms": [string],
  "duration": string | null,
  "severity": "mild" | "moderate" | "severe" | null,
  "risk_factors": [string]
}

Do not invent data.
`;

export async function extractSymptoms(text: string) {
    try {
        const res = await callLLM(SYSTEM, text);
        const match = res.match(/\{[\s\S]*\}/);
        const jsonStr = match ? match[0] : res;
        return JSON.parse(jsonStr);
    } catch (e) {
        console.error("Failed to parse symptoms JSON", e);
        return { symptoms: [] };
    }
}
