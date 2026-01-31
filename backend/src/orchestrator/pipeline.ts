import { safetyGuard } from "../agents/safetyGuard";
import { extractSymptoms } from "../agents/symptomExtractor";
import { llmTriage } from "../agents/triageAgent";
import { generateAnswer } from "../agents/answwerGenerator";
import { validate } from "../agents/safetyValidator";
import { retrieve } from "../rag/retriever";
import { ruleBasedTriage } from "../triage/rules";
import { buildContext } from "../agents/contextBuilder";
import { detectDistortion } from "../cbt/distortionDetector";
import { generateReframing } from "../cbt/reframingGenerator";
import { generateDoctorSummary } from "../health/summaryGenerator";
import { saveJournal } from "../memory/journalstore";

export async function runPipeline(userId: string, userText: string) {
    const safe = safetyGuard(userText);
    if (!safe.allowed) return safe.message;

    // Load Context
    const context = buildContext(userId, userText);

    // Save to journal (simple)
    saveJournal({ userId, text: userText, timestamp: new Date() });

    // Check for Summary Request
    if (userText.toLowerCase().includes("summary") || userText.toLowerCase().includes("report")) {
        // Fetch recent reports for summary
        const reports = await retrieve("patient history medical report outcome", userId);
        return await generateDoctorSummary({ ...context, reports });
    }

    const structured = await extractSymptoms(userText);
    const aiTriage = await llmTriage(structured);
    const ruleTriage = ruleBasedTriage(structured.symptoms || []);

    const finalTriage =
        ruleTriage === "HIGH" || aiTriage === "HIGH" ? "HIGH" :
            ruleTriage === "MEDIUM" || aiTriage === "MEDIUM" ? "MEDIUM" :
                "LOW";

    const docs = await retrieve(`${userText} ${(structured.symptoms || []).join(" ")}`, userId);

    // CBT Layer
    let additionalInfo = "";
    try {
        const distortion = await detectDistortion(userText);
        if (distortion && distortion.distortion !== "None") {
            const reframing = await generateReframing(distortion.distortion, userText);
            additionalInfo = `\n\n**CBT Insight**: ${reframing}`;
        }
    } catch (e) {
        console.error("CBT Error", e);
    }

    const answer = await generateAnswer({ ...structured, context }, docs, finalTriage);

    const safeAnswer = await validate(answer + additionalInfo);

    return safeAnswer;
}