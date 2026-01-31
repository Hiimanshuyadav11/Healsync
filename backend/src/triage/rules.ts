export function ruleBasedTriage(symptoms: string[]) {
    const s = symptoms.join(" ").toLowerCase();

    if (
        s.includes("chest pain") ||
        s.includes("can't breathe") ||
        s.includes("unconscious") ||
        s.includes("high blood pressure") ||
        s.includes("high migraine")
    ) {
        return "HIGH";

    }
    if (
        s.includes("fever") ||
        s.includes("vomiting") ||
        s.includes("pain for some days or diarrhea") ||
        s.includes("dogbite with blood stains") ||
        s.includes("skin infection")
    ) {
        return "MEDIUM";
    }
    return "LOW";
}