-- Task 5.3, Part A:

SELECT
    h.hashtag_name,
    pm.media_code
FROM hashtags h
CROSS JOIN (
    SELECT DISTINCT media_code
    FROM post_media
) pm

ORDER BY h.hashtag_name, pm.media_code;

SELECT
    (SELECT COUNT(*) FROM hashtags) AS hashtag_count,
    (SELECT COUNT(DISTINCT media_code) FROM post_media) AS media_count,
    (SELECT COUNT(*) FROM hashtags) *
    (SELECT COUNT(DISTINCT media_code) FROM post_media) AS expected_combinations;

-- Task 5.3, Part B:

EXPLAIN
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