-- task 5.1, q1
SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

SELECT
    l.like_id,
    u.user_id,
    u.user_name,
    p.post_id,
    p.post_title,
    l.liked_at
FROM likes l
INNER JOIN users u
    ON l.user_id = u.user_id
INNER JOIN posts p
    ON l.post_id = p.post_id
ORDER BY l.liked_at;

-- Task 5.1, q2:
SELECT
    hashtag_id,
    hashtag_name,
    hashtag_description
FROM hashtags
ORDER BY hashtag_id;


SELECT
    p.post_id,
    p.post_title,
    p.author_country,
    h.hashtag_name,
    ph.tagged_on
FROM posts p
INNER JOIN post_hashtags ph
    ON p.post_id = ph.post_id
INNER JOIN hashtags h
    ON ph.hashtag_id = h.hashtag_id
WHERE h.hashtag_name = 'tech'
ORDER BY p.post_id;


-- 5.1, q3:
WITH post_metrics AS (
    SELECT
        p.post_id,
        p.post_title,
        p.author_country,
        COUNT(l.like_id) AS total_likes,
        COUNT(l.like_id) FILTER (
            WHERE l.reaction_status = 'removed'
        ) AS removed_likes,
        ROUND(
            100.0 * COUNT(l.like_id) FILTER (
                WHERE l.reaction_status = 'removed'
            ) / NULLIF(COUNT(l.like_id), 0),
            2
        ) AS removal_rate
    FROM posts p
    LEFT JOIN likes l
        ON p.post_id = l.post_id
    GROUP BY
        p.post_id,
        p.post_title,
        p.author_country
)
SELECT
    p1.post_id,
    p1.post_title,
    p1.author_country,
    p1.total_likes,
    p1.removed_likes,
    p1.removal_rate,
    p2.post_id AS comparison_post_id,
    p2.post_title AS comparison_post_title,
    p2.total_likes AS comparison_total_likes,
    p2.removed_likes AS comparison_removed_likes,
    p2.removal_rate AS comparison_removal_rate
FROM post_metrics p1
INNER JOIN post_metrics p2
    ON p1.author_country = p2.author_country
    AND p1.post_id < p2.post_id
ORDER BY p1.post_id, p2.post_id;