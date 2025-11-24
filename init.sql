CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS episodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    audio_url TEXT NOT NULL,
    duration_seconds INT,
    position INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS listening_progress (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    episode_id UUID REFERENCES episodes(id) ON DELETE CASCADE,
    last_position_seconds INT DEFAULT 0,
    completed BOOLEAN DEFAULT FALSE,
    updated_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(user_id, episode_id)
);

-- seed episodes (replace these URLs with real hosted audio if available)
INSERT INTO episodes (title, audio_url, duration_seconds)
VALUES
('Intro to Financial Literacy', 'https://cdn.simple-audio.example/finance_ep1.mp3', 420)
ON CONFLICT DO NOTHING;

INSERT INTO episodes (title, audio_url, duration_seconds)
VALUES
('Budgeting Basics', 'https://cdn.simple-audio.example/finance_ep2.mp3', 900)
ON CONFLICT DO NOTHING;

INSERT INTO episodes (title, audio_url, duration_seconds)
VALUES
('Saving & Emergency Funds', 'https://cdn.simple-audio.example/finance_ep3.mp3', 780)
ON CONFLICT DO NOTHING;
