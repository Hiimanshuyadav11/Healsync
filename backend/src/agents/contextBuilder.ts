import { getLastJournals } from "../memory/journalstore";

export function buildContext(userId: string, current: any) {
    const history = getLastJournals(userId);
    return {
        current,
        history
    };
}
