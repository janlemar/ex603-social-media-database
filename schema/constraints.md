# Task 1.3: Specify Integrity Constraints

### 1. likes.user_id

- Foreign Key: `user_id`

- From: `users.user_id`

- ON DELETE: CASCADE

- If a user is deleted, the likes should be deleted as well. Since that specific user liked a post, once they delete the account the likes are no longer associated to an existing user.

### 2. likes.post_id

- Foreign Key: `post_id`

- From: `posts.post_id`

- ON DELETE: CASCADE

- If a post is deleted, all of its likes should be deleted too. There's no reason to keep the likes from a post that doesn't exist.

### 3. post_hashtags.post_id

- Foreign Key: `post_id`

- From: `posts.post_id`

- ON DELETE: CASCADE

- If a post is deleted, the connected hashtags should be as well. A hashtag is only associated to that specific post if it was attached to the post itself. A hashtag can still have multiple posts, but the relation to the post deleted will be removed.

### 4. post_hashtags.hashtag_id

- Foreign Key: `hashtag_id`

- From: `hashtags.hashtag_id`

- ON DELETE: CASCADE

- If a hashtage is deleted from a post, its relation with posts should be removed as well. You can't have records with a post that doesn't include a hashtag that no longer exists.