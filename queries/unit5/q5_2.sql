-- Task 5.2, Part a

SELECT
    p.post_id,
    p.post_title,
    p.author_country,
    COUNT(l.like_id) AS total_likes
FROM posts p
LEFT JOIN likes l
    ON p.post_id = l.post_id
GROUP BY
    p.post_id,
    p.post_title,
    p.author_country
ORDER BY p.post_id;

SELECT
    p.post_id,
    p.post_title,
    p.author_country,
    COUNT(l.like_id) AS total_likes
FROM posts p
INNER JOIN likes l
    ON p.post_id = l.post_id
GROUP BY
    p.post_id,
    p.post_title,
    p.author_country
ORDER BY p.post_id;

-- Task 5.2, Part B (right):

SELECT
    p.post_id,
    p.post_title,
    p.author_country,
    COUNT(l.like_id) AS total_likes
FROM likes l
RIGHT JOIN posts p
    ON l.post_id = p.post_id
GROUP BY
    p.post_id,
    p.post_title,
    p.author_country
ORDER BY p.post_id;

-- Task 5.2, Part B (full outer join):

SELECT
    p.post_id,
    p.post_title,
    l.like_id,
    l.liked_at
FROM posts p
FULL OUTER JOIN likes l
    ON p.post_id = l.post_id
ORDER BY p.post_id, l.like_id;

-- Task 5.2, Part C:

SELECT
    p.post_id,
    p.post_title,
    p.author_country
FROM posts p
WHERE NOT EXISTS (
    SELECT 1
    FROM likes l
    WHERE l.post_id = p.post_id
)
ORDER BY p.post_id;

-- not exists

SELECT post_id
FROM posts

EXCEPT

SELECT post_id
FROM likes

ORDER BY post_id;