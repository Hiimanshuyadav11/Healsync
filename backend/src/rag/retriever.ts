import { qdrant } from "./qdrant";
import { getEmbedding } from "../llm/embeddings";

export async function retrieve(query: string, userId?: string) {
    const vector = await getEmbedding(query);

    const filter: any = {
        must: [
            { key: "type", match: { value: "report" } }
        ]
    };

    if (userId) {
        filter.must.push({ key: "userId", match: { value: userId } });
    }

    const results = await qdrant.search(process.env.QDRANT_COLLECTION!, {
        vector,
        filter: filter,
        limit: 5
    });

    return results.map(r => ({
        content: r.payload?.text as string,
        score: r.score
    }));
}
