import { callLLM } from "../llm/client";

const SYSTEM = `
You are a CBT therapist.
Generate a structured cognitive reframing exercise.
Do not act as a doctor.
`;

export async function generateReframing(distortion: string, text: string) {
    return callLLM(SYSTEM, `
Distortion: ${distortion}
User thought: ${text}

Generate:
1. Identify thought
2. Challenge it
3. Balanced alternative
`);
}
