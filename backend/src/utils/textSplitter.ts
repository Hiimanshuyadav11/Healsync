export class RecursiveCharacterTextSplitter {
    private chunkSize: number;
    private chunkOverlap: number;
    private separators: string[];

    constructor(chunkSize: number = 1000, chunkOverlap: number = 200) {
        this.chunkSize = chunkSize;
        this.chunkOverlap = chunkOverlap;
        this.separators = ["\n\n", "\n", ". ", " ", ""];
    }

    async splitText(text: string): Promise<string[]> {
        const finalChunks: string[] = [];
        let goodSplits: string[] = [];

        // Initial split by the first separator
        goodSplits = this._splitText(text, this.separators);

        return goodSplits;
    }

    private _splitText(text: string, separators: string[]): string[] {
        const finalChunks: string[] = [];
        let separator = separators[0];
        let newSeparators = [];

        for (let i = 0; i < separators.length; i++) {
            if (text.includes(separators[i])) {
                separator = separators[i];
                newSeparators = separators.slice(i + 1);
                break;
            }
        }

        const splits = text.split(separator);
        let currentChunk: string[] = [];
        let currentLength = 0;

        for (const split of splits) {
            const splitLength = split.length;
            if (currentLength + splitLength > this.chunkSize) {
                if (currentLength > 0) {
                    finalChunks.push(currentChunk.join(separator).trim()); // Join with the separator that was used to split
                    // Handle overlap (simplified) - keep last few items if possible, but for now just reset
                    // TODO: meaningful overlap implementation
                    currentChunk = [];
                    currentLength = 0;
                }
            }
            currentChunk.push(split);
            currentLength += splitLength + separator.length;
        }

        if (currentChunk.length > 0) {
            finalChunks.push(currentChunk.join(separator).trim());
        }

        return finalChunks.filter(c => c.length > 0);
    }
}

export const splitText = async (text: string, chunkSize: number = 1000, chunkOverlap: number = 200): Promise<string[]> => {
    const splitter = new RecursiveCharacterTextSplitter(chunkSize, chunkOverlap);
    return splitter.splitText(text);
};
