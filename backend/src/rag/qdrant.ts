import { QdrantClient } from "@qdrant/js-client-rest";

export const qdrant = new QdrantClient({
    url: process.env.QDRANT_URL!,
});

export async function ensureCollection() {
    const name = process.env.QDRANT_COLLECTION!;
    try {
        await qdrant.getCollection(name);
    } catch (e) {
        console.log(`Collection ${name} not found, creating...`);
        await qdrant.createCollection(name, {
            vectors: { size: 768, distance: "Cosine" }
        });
        console.log(`Collection ${name} created.`);
    }
}
