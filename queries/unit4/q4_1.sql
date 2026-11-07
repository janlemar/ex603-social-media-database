-- Task 4.1, q1
SELECT
    COUNT(*) AS total_events,
    COUNT(dwell_ms) AS events_with_dwell_time,
    SUM(dwell_ms) AS total_dwell_ms,
    ROUND(AVG(dwell_ms), 2) AS average_dwell_ms,
    MIN(dwell_ms) AS minimum_dwell_ms,
    MAX(dwell_ms) AS maximum_dwell_ms,
    COUNT(DISTINCT user_id) AS distinct_actors
FROM likes;

-- Task 4.1, Q2

SELECT
    p.post_id,
    COUNT(*) AS total_events,
    ROUND(AVG(l.dwell_ms), 2) AS average_dwell_ms
FROM likes l
JOIN posts p ON l.post_id = p.post_id
GROUP BY p.post_id
ORDER BY total_events DESC, p.post_id;

-- Task 4.1, Q3

SELECT
    l.post_id,
    COUNT(*) AS total_events,
    SUM(CASE WHEN l.reaction_status = 'removed' THEN 1 ELSE 0 END) AS removed_events,
    ROUND(
        100.0 * SUM(CASE WHEN l.reaction_status = 'removed' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS removal_rate_pct
FROM likes l
GROUP BY l.post_id
HAVING COUNT(*) >= 10
ORDER BY removal_rate_pct DESC, total_events DESC;

-- Task 4.1, Q4
SELECT
    l.post_id,
    l.client_country AS region,
    COUNT(*) AS total_events,
    SUM(CASE WHEN l.reaction_status = 'removed' THEN 1 ELSE 0 END) AS removed_events,
    ROUND(AVG(l.dwell_ms), 2) AS average_dwell_ms
FROM likes l
GROUP BY l.post_id, l.client_country
ORDER BY l.post_id, region;