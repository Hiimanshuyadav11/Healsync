import { callLLM } from "../llm/client";

const SYSTEM = `
Summarize patient history for a doctor.
Use professional tone.
Short, structured.
`;

export async function generateDoctorSummary(data: any) {
    const contextData = {
        ...data,
        attachedReports: data.reports?.map((r: any) => r.content).join("\n\n") || "No reports found."
    };
    return callLLM(SYSTEM, JSON.stringify(contextData));
}
