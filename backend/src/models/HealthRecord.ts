import mongoose from "mongoose";

const HealthRecordSchema = new mongoose.Schema({
    userId: mongoose.Schema.Types.ObjectId,
    type: String,
    data: Object,
    createdAt: { type: Date, default: Date.now }

});

export const HealthRecord = mongoose.model("HealthRecord", HealthRecordSchema);