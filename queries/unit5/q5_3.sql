# Unit 5 Assignment
## by Jan Lemar Baltazar

## Task 5.1

### Question 1

I joined `likes`, `users`, and `posts` to show which users liked which posts and when. The query returned 200 records. This type of join could be used for an activity report where administrators can see who interacted with a post and when.

### Question 2

I joined `posts` and `hashtags` through `post_hashtags` and filtered for the `tech` hashtag. The query returned five posts: 2, 3, 5, 10, and 11.

The junction table is important because posts and hashtags have a many-to-many relationship. It allows one post to have multiple hashtags and one hashtag to be associated with multiple posts.

### Question 3

I used a self join to compare posts from the same author country. I also used a CTE to calculate likes, removed likes, and removal rates. Post 11 from Vietnam had a 31.25% removal rate, while Post 6 from Vietnam had 19.05%. This shows that posts from the same country can have different performance. But, this does not mean the country itself caused the difference.


## Task 5.2

### Part A

The LEFT JOIN returned all 15 posts, including Posts 14 and 15, which had zero likes. The INNER JOIN returned only 13 posts because it excluded posts without matching likes. 
This means an INNER JOIN-only report could leave out posts that have never received engagement.

### Part B

The RIGHT JOIN returned the same 15 posts as the LEFT JOIN. The FULL OUTER JOIN returned 202 rows, including the 200 likes and two posts without matching likes. There were no unmatched likes.
The FULL OUTER JOIN provides a more full view because it preserves unmatched records from both tables.

### Part C

Both NOT EXISTS and EXCEPT returned Posts 14 and 15.
NOT EXISTS checks for the absence of matching records, while EXCEPT subtracts the post IDs found in `likes` from all post IDs. 
Both methods helped confirm which posts had never received a like.


## Task 5.3

### Part A

I used a CROSS JOIN between `hashtags` and the distinct media types in `post_media`. There were five hashtags and five media types, which produced a total of 25 combinations (5 × 5).
CROSS JOIN is useful when every possible combination is needed, but I think it can create unnecessary results when used accidentally, especially with larger tables.

### Part B

I used EXPLAIN on my three-table join from Task 5.1. PostgreSQL selected a Hash Join to connect likes and users, followed by a Nested Loop and Index Scan to find matching posts. The plan also included Memoize and Sort operations.
These operations show how PostgreSQL chooses different strategies to retrieve and organize records.

### Reflection

PostgreSQL chooses join algorithms based on factors such as table size, available indexes, and the number of matching records. Basically, as a database grows, the planner may choose a different algorithm because the estimated cost of the query changes.
For example, adding more records could make a Hash Join more efficient than a Nested Loop. Adding indexes to frequently used join columns could also make lookups faster. Changes in the number of matching records can affect the planner's decisions as well.

In my execution plan, PostgreSQL used a Hash Join, Nested Loop, and Index Scan. It also used Memoize and Sort operations. This helped me understand that PostgreSQL can combine different strategies within one query.

I think understanding execution plans becomes more important as a database grows. A query that performs well with a small dataset might become slower with thousands or millions of records. Using EXPLAIN helps identify how PostgreSQL processes a query and where performance improvements might be needed.