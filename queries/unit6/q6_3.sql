-- task 6.3 part A

WITH ranked_posts AS (
    SELECT
        likes.like_id,
        likes.post_id,
        posts.post_title,
        likes.liked_at,
        likes.dwell_ms,

        RANK() OVER (
            PARTITION BY likes.post_id
            ORDER BY likes.dwell_ms DESC
        ) AS event_rank,

        FIRST_VALUE(likes.dwell_ms) OVER (
            PARTITION BY likes.post_id
            ORDER BY likes.dwell_ms DESC, likes.liked_at, likes.like_id
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
        ) AS highest_dwell

    FROM likes
    JOIN posts ON likes.post_id = posts.post_id
)

SELECT
    like_id,
    post_id,
    post_title,
    liked_at,
    dwell_ms,
    event_rank,
    highest_dwell
FROM ranked_posts
WHERE event_rank <= 3
ORDER BY post_id, event_rank, like_id;

-- part B

WITH monthly_totals AS (
    SELECT
        DATE_TRUNC('month', likes.liked_at)::date AS event_month,
        COUNT(likes.like_id) AS monthly_events
    FROM likes
    GROUP BY DATE_TRUNC('month', likes.liked_at)
),

monthly_changes AS (
    SELECT
        event_month,
        monthly_events,

        LAG(event_month) OVER (
            ORDER BY event_month
        ) AS previous_month,

        LAG(monthly_events) OVER (
            ORDER BY event_month
        ) AS previous_month_events

    FROM monthly_totals
)

SELECT
    event_month,
    monthly_events,
    previous_month,
    previous_month_events,

    ROUND(
        100.0 * (monthly_events - previous_month_events)
        / NULLIF(previous_month_events, 0),
        2
    ) AS percent_change,

    CASE
        WHEN previous_month IS NULL THEN 'First month'
        WHEN event_month = (previous_month + INTERVAL '1 month')::date THEN 'Consecutive month'
        ELSE 'Possible missing month'
    END AS month_check

FROM monthly_changes
ORDER BY event_month;