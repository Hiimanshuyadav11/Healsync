import { callLLM } from "../llm/client";

const SYSTEM = `
You are a medical guidance assistant.

Rules:
- Do not diagnose
- Do not prescribe medicine
- Always say you are not a doctor
- Always suggest seeing a professional
- Use cautious language
`;

export async function generateAnswer(context: any, docs: any[], triage: string) {
    const prompt = `
User info:
${JSON.stringify(context)}

Triage: ${triage}

Sources:
${docs.map(d => d.content).join("\n")}

Write a helpful, safe response.
`;

    return callLLM(SYSTEM, prompt);
}
