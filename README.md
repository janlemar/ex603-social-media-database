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