import express from "express";
import bcrypt from "bcrypt";
import { User } from "../models/User";
import { signToken } from "../auth/jwt";

const router = express.Router();

router.post("/register", async (req, res) => {
    const existing = await User.findOne({ email: req.body.email });
    if (existing) return res.status(400).json({ error: "User already exists" });

    const hash = await bcrypt.hash(req.body.password, 10);
    const user = await User.create({ email: req.body.email, passwordHash: hash });
    res.json({ token: signToken(user.id) });
});

router.post("/login", async (req, res) => {
    const user = await User.findOne({ email: req.body.email });
    if (!user) return res.status(401).send("Invalid");

    const ok = await bcrypt.compare(req.body.password, user.passwordHash || "");
    if (!ok) return res.status(401).send("Invalid");

    res.json({ token: signToken(user.id) });
});

export default router;
