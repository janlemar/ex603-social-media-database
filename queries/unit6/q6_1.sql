-- 6.1 average

SELECT
    likes.like_id,
    likes.post_id,
    posts.post_title,
    likes.dwell_ms,

    ROUND(
        AVG(likes.dwell_ms) OVER (
            PARTITION BY likes.post_id
        )::numeric,
        2
    ) AS post_avg_dwell_ms

FROM likes
JOIN posts
    ON likes.post_id = posts.post_id

ORDER BY likes.post_id, likes.liked_at;

-- 6.1 ranking

WITH producer_counts AS (
    SELECT
        posts.post_id AS producer,
        COUNT(likes.like_id) AS event_count
    FROM posts
    LEFT JOIN likes
        ON posts.post_id = likes.post_id
    GROUP BY posts.post_id
)

SELECT
    producer,
    event_count,

    ROW_NUMBER() OVER (
        ORDER BY event_count DESC, producer
    ) AS row_number_rank,

    RANK() OVER (
        ORDER BY event_count DESC
    ) AS rank_value,

    DENSE_RANK() OVER (
        ORDER BY event_count DESC
    ) AS dense_rank_value,

    NTILE(4) OVER (
        ORDER BY event_count DESC
    ) AS quartile

FROM producer_counts
ORDER BY event_count DESC, producer;