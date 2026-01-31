import mongoose from "mongoose";

const JournalSchema = new mongoose.Schema({
    userId: mongoose.Schema.Types.ObjectId,
    text: String,
    sentiment: Number,
    distortionType: String,
    createdAt: { type: Date, default: Date.now }
})

export const Journal = mongoose.model("Journal", JournalSchema);