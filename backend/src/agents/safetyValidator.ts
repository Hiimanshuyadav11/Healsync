import { callLLM } from "../llm/client";

const SYSTEM = `
You are a safety validator for a health chatbot.
Your job is to ensure the text is safe, has a disclaimer, and makes no diagnoses.

Rules:
1. If the text is safe, RETURN IT EXACTLY AS IS.
2. If the text has issues (diagnosis, prescription, overconfidence), REWRITE it to be safe.
3. DO NOT output any analysis, explanation, or "Check/Fix" lists.
4. OUTPUT ONLY THE FINAL TEXT.
`;

export async function validate(answer: string) {
    return callLLM(SYSTEM, answer);
}
