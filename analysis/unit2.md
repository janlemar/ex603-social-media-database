# Unit 2
## Task 2.2 Write up your reasoning
**by Jan Lemar Baltazar**

### Foreign Key Constraints

| Foreign Key | ON DELETE Choice | Reason |
|---|---|---|
| `likes.user_id` → `users.user_id` | CASCADE | If a user is deleted, their likes should be deleted too because those likes would no longer belong to an existing user. |
| `likes.post_id` → `posts.post_id` | CASCADE | If a post is deleted, the likes for that post should be deleted because the post does not exist anymore |
| `post_hashtags.post_id` → `posts.post_id` | CASCADE | If a post is deleted, its hashtag connections should be deleted. BUT the hashtags themselves should remain (only the post associated with that hashtag is removed). |
| `post_hashtags.hashtag_id` → `hashtags.hashtag_id` | CASCADE | If a hashtag is deleted, its connections to posts should be deleted because the hashtag no longer exists. |

### ON DELETE Reasoning

I chose CASCADE for `likes.user_id` because if a user deletes their account, I do not think their likes should stay. It doesn't make sense to keep that data when that user no longer exists, and since their likes were created within that account. 

I chose CASCADE for `likes.post_id` because there is no reason to keep the likes that belonged to that post. Once a post is deleted, the like data will be removed as well. If I used a different option like RESTRICT, the post could be prevented from being deleted until its likes were removed first.

I chose CASCADE for `post_hashtags.post_id` because the connection to that hashtag only exists because that post uses the hashtag. If the post is deleted, the connection should disappear too. However, the hashtag itself should not be deleted because other posts could still be using it.

I chose CASCADE for `post_hashtags.hashtag_id` because if a hashtag is deleted, the connections between that hashtag and posts should also be removed. If it's delted, there's nothing left for that connection to point to. 

### CHECK Constraints

I added a CHECK constraint to `posts.character_count` that requires the value to be zero or greater. This prevents a post from having a negative character count. A negative number would not make sense for the number of characters in a post. A caption's length cannot be negative. 

I also added a CHECK constraint to `likes.dwell_ms` that requires the value to be zero or greater. This prevents a like from having a negative dwell time. Dwell time is basically how long a user spent viewing something, so a negative amount of time would not make sense. Without the CHECK constraint, a negative integer can be stored.