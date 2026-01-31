export function safetyGuard(userText: string) {
    const redFlags = ['suicide', 'harm', 'self-harm', 'die', 'kill myself', "chest pain unable to breathe", "unconscious", "high blood pressure say more than 150/100", "high migraine"];

    for (const flag of redFlags) {
        if (userText.toLowerCase().includes(flag)) {
            return {
                allowed: false,
                message: "This sounds alarming and potentially dangerous.Please seek immediate medical help or go to the doctor"
            };
        }
    }
    return {
        allowed: true,
        message: ""
    };

}