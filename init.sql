-- ================================
-- 1. USERS TABLE (Authentication)
-- ================================
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ================================
-- 2. EPISODES TABLE
-- ================================
CREATE TABLE IF NOT EXISTS episodes (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    audio_url TEXT NOT NULL,
    duration_seconds INT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ================================
-- 3. LISTENING PROGRESS TABLE
-- ================================
CREATE TABLE IF NOT EXISTS listening_progress (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    episode_id INTEGER NOT NULL REFERENCES episodes(id) ON DELETE CASCADE,
    progress_seconds INT DEFAULT 0,
    updated_at TIMESTAMP DEFAULT NOW(),

    UNIQUE (user_id, episode_id)
);

-- ================================
-- 4. INSERT SAMPLE EPISODES
-- ================================
INSERT INTO episodes (title, description, audio_url, duration_seconds)
VALUES
('Introduction to Finance', 'Basics of financial literacy.', 'https://example.com/audio1.mp3', 300),
('Saving & Budgeting', 'Learn how to manage money.', 'https://example.com/audio2.mp3', 420),
('Investing Basics', 'Beginner friendly investing concepts.', 'https://example.com/audio3.mp3', 600)
ON CONFLICT DO NOTHING;

