# Relation Schema: Social Media Theme

1. users (actor)
2. posts (producer)
3. likes (event)
4. hashtags (catalog)
5. post_hashtags (junction)

Metric: dwell_ms

## 1. users (Actor)
**Relation:** users

**Schema:** users(user_id, username)

**Domains:**
- user_id: integer
- username: strings of alphanumeric characters and underscores, variable length (max 30)

**Primary Key:** user_id

## 2. posts (Producer)
**Relation:** posts

**Schema:** posts(post_id, caption, is_active, character_count)

**Domains:**
- post_id: integer
- caption: variable-length text describing the content of the post (description)
- is_active: boolean (true or false)
- character_count: non-negative integer

**Primary Key:** post_id

## 3. likes (event)
**Relation:** likes

**Schema:** likes(like_id, user_id, post_id, liked_at, dwell_ms)

**Domains:**
- like_id: integer
- user_id: integer
- post_id: integer
- liked_at: timestamp and dates, format is yyyy-mm-dd hh:mm:ss
- dwell_ms: non-negative integer (ms)

**Primary Key:** like_id

## 4. hashtags (catalog)
**Relation:** hashtags

**Schema:** hashtags(hashtag_id, name)

**Domains:**
- hashtag_id: integer
- name: variable-length string of alphanumeric characters

**Primary Key:** hashtag_id

## 5. post_hashtags (junction)
**Relation:** post_hashtags

**Schema:** post_hashtags(post_id, hashtag_id)

**Domains:**
- post_id: integer
- hashtag_id: integer

**Primary Key:** (post_id, hashtag_id)