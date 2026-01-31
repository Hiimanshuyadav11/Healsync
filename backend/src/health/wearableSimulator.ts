export function simulateWearable() {
    return {
        heartRate: 60 + Math.random() * 30,
        steps: Math.floor(Math.random() * 8000),
        sleepHours: 5 + Math.random() * 3
    };
}
