import { callLLM } from "../llm/client";

const SYSTEM = `
Classify urgency as LOW, MEDIUM, or HIGH.

HIGH = dangerous or urgent
MEDIUM = see doctor soon
LOW = likely safe to monitor

Be conservative.
Return only one word.
`;

export async function llmTriage(structured: any): Promise<"LOW" | "MEDIUM" | "HIGH"> {
    const res = await callLLM(SYSTEM, JSON.stringify(structured));
    return res.trim() as any;
}
