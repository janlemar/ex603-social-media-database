SELECT reaction_status, COUNT(*) AS total
FROM likes
GROUP BY reaction_status
ORDER BY reaction_status;