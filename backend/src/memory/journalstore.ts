const journal: any[] = [];

export function saveJournal(entry: any) {
    journal.push(entry);
}

export function getLastJournals(userId: string, n = 5) {
    return journal.filter(j => j.userId === userId).slice(-n);
}
