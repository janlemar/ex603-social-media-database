# Social Media Database (EX603)
**by Jan Lemar Baltazar**

**Theme**: Social Media

## Schema

This project models a social media platform using five relations:

- `users` — stores the users of the social media platform.
- `posts` — stores the posts created on the platform.
- `likes` — records which users like which posts, along with the time of the like and dwell time.
- `hashtags` — stores the hashtags used by posts.
- `post_hashtags` — connects posts and hashtags through a many-to-many relationship.

The `likes` and `post_hashtags` tables use composite primary keys to prevent any duplicate relationships. The foreign keys use `ON DELETE CASCADE` so any likes and hashtag associations are removed when their referenced records are deleted (like deleting a user/post/hashtag). The schema also uses CHECK constraints to avoid any negative character counts and negative dwell times.

## Unit 4 Additions 
Queries

- /queries/unit4/q4_1.sql 
-- Task 4.1 — the baseline, per-producer, HAVING, and two-dimension queries. 

- /queries/unit4/q4_2.sql 
-- Task 4.2 — conditional aggregation, ROLLUP, and the pipeline. 

- /analysis/unit4.md 
-- The write-ups for Tasks 4.1 and 4.2, plus the reflection. 
   
- /analysis/unit4-finding.md 
-- Task 4.3 — the breakdown for leadership. 

