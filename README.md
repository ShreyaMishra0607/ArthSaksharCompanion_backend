# Simple Audiobook Backend (Single Finance Course)
Minimal Node.js + Express + PostgreSQL backend for a single-course audiobook (financial literacy).

Features:
- User registration and login (JWT + bcrypt)
- Episodes listing (pre-seeded)
- Listening progress save & fetch
- Simple SQL init script to create tables and seed episodes

Quick start (using Docker for Postgres):

1. Install Node.js (16+) and npm.
2. Create .env file from .env.example and set variables.
3. Start Postgres (Docker):
   docker-compose up -d
4. Install dependencies:
   npm install
5. Initialize DB (run the SQL script):
   psql "${DATABASE_URL}" -f init.sql
   (or use any Postgres client to run init.sql)
6. Start server:
   npm run dev
7. API base: http://localhost:4000/api

Endpoints:
- POST /api/auth/register  { name, email, password }
- POST /api/auth/login     { email, password } -> { token, user }
- GET  /api/episodes
- POST /api/progress       { episode_id, last_position_seconds, completed }
- GET  /api/progress
