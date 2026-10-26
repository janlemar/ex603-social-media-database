
-- Task 4.2, Part A

SELECT
    COUNT(*) AS total_events,
    SUM(CASE WHEN reaction_status = 'removed' THEN 1 ELSE 0 END) AS removed_events,
    SUM(CASE WHEN reaction_status = 'active' THEN 1 ELSE 0 END) AS active_events,
    SUM(CASE WHEN reaction_status = 'flagged' THEN 1 ELSE 0 END) AS flagged_events,
    ROUND(
        100.0 * SUM(CASE WHEN reaction_status = 'removed' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS removal_rate_pct
FROM likes;

-- Task 4.2, Part B

SELECT
    CASE
        WHEN GROUPING(client_country) = 1 THEN 'PLATFORM GRAND TOTAL'
        ELSE COALESCE(client_country, 'Unknown region')
    END AS region,
    COUNT(*) AS total_events,
    SUM(CASE WHEN reaction_status = 'removed' THEN 1 ELSE 0 END) AS removed_events,
    ROUND(
        100.0 * SUM(CASE WHEN reaction_status = 'removed' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS removal_rate_pct
FROM likes
GROUP BY ROLLUP(client_country)
ORDER BY GROUPING(client_country), region;

-- Task 4.2, Part C
WITH producer_metrics AS (
    SELECT
        post_id,
        COUNT(*) AS total_events,
        SUM(CASE WHEN reaction_status = 'removed' THEN 1 ELSE 0 END) AS removed_events,
        ROUND(
            100.0 * SUM(CASE WHEN reaction_status = 'removed' THEN 1 ELSE 0 END) / COUNT(*),
            2
        ) AS removal_rate_pct
    FROM likes
    GROUP BY post_id
),
high_volume_producers AS (
    SELECT *
    FROM producer_metrics
    WHERE total_events >= 10
)
SELECT
    COUNT(*) AS high_volume_posts,
    ROUND(AVG(removal_rate_pct), 2) AS average_removal_rate_pct
FROM high_volume_producers;
