-- 3.3, form 1
SELECT user_id,
       user_name
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM likes
    WHERE reaction_status = 'removed'
)
ORDER BY user_id;

-- 3.3, form 2

WITH removed_users AS (
    SELECT DISTINCT user_id
    FROM likes
    WHERE reaction_status = 'removed'
)
SELECT u.user_id,
       u.user_name
FROM users u
JOIN removed_users r
    ON u.user_id = r.user_id
ORDER BY u.user_id;

-- 3.3, form 3

SELECT u.user_id,
       u.user_name
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM likes l
    WHERE l.user_id = u.user_id
      AND l.reaction_status = 'removed'
)
ORDER BY u.user_id;

-- 3.3, verify

WITH method1 AS (
    SELECT user_id, user_name
    FROM users
    WHERE user_id IN (
        SELECT user_id
        FROM likes
        WHERE reaction_status = 'removed'
    )
),
method2 AS (
    WITH removed_users AS (
        SELECT DISTINCT user_id
        FROM likes
        WHERE reaction_status = 'removed'
    )
    SELECT u.user_id, u.user_name
    FROM users u
    JOIN removed_users r ON u.user_id = r.user_id
),
method3 AS (
    SELECT u.user_id, u.user_name
    FROM users u
    WHERE EXISTS (
        SELECT 1
        FROM likes l
        WHERE l.user_id = u.user_id
          AND l.reaction_status = 'removed'
    )
)
SELECT
    (SELECT COUNT(*) FROM method1) AS method1_rows,
    (SELECT COUNT(*) FROM method2) AS method2_rows,
    (SELECT COUNT(*) FROM method3) AS method3_rows,
    NOT EXISTS (
        (SELECT * FROM method1 EXCEPT SELECT * FROM method2)
        UNION ALL
        (SELECT * FROM method2 EXCEPT SELECT * FROM method1)
        UNION ALL
        (SELECT * FROM method1 EXCEPT SELECT * FROM method3)
        UNION ALL
        (SELECT * FROM method3 EXCEPT SELECT * FROM method1)
    ) AS identical_results;