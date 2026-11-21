-- Task 6.2

WITH post_trends AS (
    SELECT
        likes.post_id,
        posts.post_title,
        likes.liked_at,
        likes.dwell_ms,

        LAG(likes.dwell_ms) OVER (
            PARTITION BY likes.post_id
            ORDER BY likes.liked_at, likes.like_id
        ) AS previous_dwell,

        LEAD(likes.dwell_ms) OVER (
            PARTITION BY likes.post_id
            ORDER BY likes.liked_at, likes.like_id
        ) AS next_dwell

    FROM likes
    JOIN posts ON likes.post_id = posts.post_id
)

SELECT
    post_id,
    post_title,
    liked_at,
    dwell_ms,
    previous_dwell,
    next_dwell,
    dwell_ms - previous_dwell AS dwell_delta

FROM post_trends
WHERE post_id = 6
ORDER BY liked_at;

-- part b
SELECT
    likes.like_id,
    likes.post_id,
    posts.post_title,
    likes.liked_at,
    likes.dwell_ms,

    SUM(likes.dwell_ms) OVER (
        ORDER BY likes.liked_at, likes.like_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_dwell,

    ROUND(
        AVG(likes.dwell_ms) OVER (
            ORDER BY likes.liked_at, likes.like_id
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_dwell,

    2000000 AS target_dwell,

    2000000 - SUM(likes.dwell_ms) OVER (
        ORDER BY likes.liked_at, likes.like_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS dwell_remaining

FROM likes
JOIN posts ON likes.post_id = posts.post_id
ORDER BY likes.liked_at, likes.like_id;

-- part C

WITH posting_gaps AS (
    SELECT
        likes.post_id,
        posts.post_title,
        likes.liked_at,

        LAG(likes.liked_at) OVER (
            PARTITION BY likes.post_id
            ORDER BY likes.liked_at, likes.like_id
        ) AS previous_like_date

    FROM likes
    JOIN posts ON likes.post_id = posts.post_id
),

gap_results AS (
    SELECT
        post_id,
        post_title,
        previous_like_date,
        liked_at,
        liked_at - previous_like_date AS days_between_likes
    FROM posting_gaps
)

SELECT *
FROM gap_results
WHERE days_between_likes >= INTERVAL '30 days'
ORDER BY days_between_likes DESC;