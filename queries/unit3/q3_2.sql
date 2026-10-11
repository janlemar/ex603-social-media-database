-- 3.2A: Compare the original count, missing values, and the table total
SELECT
    (SELECT COUNT(*)
     FROM likes
     WHERE removal_reason <> 'Spam detected') AS original_count,

    (SELECT COUNT(*)
     FROM likes
     WHERE removal_reason IS NULL) AS missing_count,

    (SELECT COUNT(*)
     FROM likes) AS table_total;

-- 3.2B: Demonstrate the alias bug.
SELECT like_id,
       dwell_ms / 1000.0 AS dwell_seconds
FROM likes
WHERE dwell_seconds > 1;

-- 3.2b: fix 1 - Repeat the expression in WHERE
SELECT like_id,
       dwell_ms / 1000.0 AS dwell_seconds
FROM likes
WHERE dwell_ms / 1000.0 > 1;

-- 3.2B: fix 2 - using a cte
WITH reaction_times AS (
    SELECT like_id,
           dwell_ms / 1000.0 AS dwell_seconds
    FROM likes
)
SELECT like_id,
       dwell_seconds
FROM reaction_times
WHERE dwell_seconds > 1;