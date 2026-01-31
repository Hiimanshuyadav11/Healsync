import { callLLM } from "../llm/client";

const SYSTEM = `
You are a CBT expert.
Classify the cognitive distortion in the text.

Return JSON:
{
  "distortion": "Catastrophizing | Overgeneralization | MindReading | None",
  "sentiment": -1 to 1
}
`;

export async function detectDistortion(text: string) {
    const res = await callLLM(SYSTEM, text);
    const cleaned = res.replace(/```json|```/g, "").trim();
    return JSON.parse(cleaned);
}
