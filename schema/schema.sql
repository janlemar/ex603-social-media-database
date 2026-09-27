-- =================================================================
-- EX 603 Assignment 2 — schema.sql
-- Theme: Social Media
-- Author: Jan Lemar Baltazar
-- Target: PostgreSQL 14+
-- =================================================================

-- Reset. reverse creation order, so no dependency blocks a drop.

DROP TABLE IF EXISTS post_hashtags CASCADE;
DROP TABLE IF EXISTS likes CASCADE;
DROP TABLE IF EXISTS hashtags CASCADE;
DROP TABLE IF EXISTS posts CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ----------------------------------------------------------------
-- 1. users
-- ----------------------------------------------------------------

CREATE TABLE users (
    user_id INTEGER GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(30) NOT NULL,

    CONSTRAINT pk_users
        PRIMARY KEY (user_id)
);

-- ----------------------------------------------------------------
-- 2. posts
-- ----------------------------------------------------------------

CREATE TABLE posts (
    post_id INTEGER GENERATED ALWAYS AS IDENTITY,
    caption TEXT,
    is_active BOOLEAN NOT NULL,
    character_count INTEGER NOT NULL,

    CONSTRAINT pk_posts
        PRIMARY KEY (post_id),

    CONSTRAINT chk_posts_character_count
        CHECK (character_count >= 0)
);

-- ----------------------------------------------------------------
-- 3. hashtags
-- ----------------------------------------------------------------

CREATE TABLE hashtags (
    hashtag_id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,

    CONSTRAINT pk_hashtags
        PRIMARY KEY (hashtag_id)
);

-- ----------------------------------------------------------------
-- 4. likes
-- ----------------------------------------------------------------

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    liked_at TIMESTAMP NOT NULL,
    dwell_ms INTEGER NOT NULL,

    CONSTRAINT pk_likes
        PRIMARY KEY (user_id, post_id),

    CONSTRAINT fk_likes_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_likes_post
        FOREIGN KEY (post_id)
        REFERENCES posts(post_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_likes_dwell_ms
        CHECK (dwell_ms >= 0)
);

-- ----------------------------------------------------------------
-- 5. post_hashtags
-- ----------------------------------------------------------------

CREATE TABLE post_hashtags (
    post_id INTEGER NOT NULL,
    hashtag_id INTEGER NOT NULL,

    CONSTRAINT pk_post_hashtags
        PRIMARY KEY (post_id, hashtag_id),

    CONSTRAINT fk_post_hashtags_post
        FOREIGN KEY (post_id)
        REFERENCES posts(post_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_post_hashtags_hashtag
        FOREIGN KEY (hashtag_id)
        REFERENCES hashtags(hashtag_id)
        ON DELETE CASCADE
);