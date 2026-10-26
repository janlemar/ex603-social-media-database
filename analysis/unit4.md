# Project Assignment 4: From Rows to Insight

## Task 4.1
### Question 1
The database contains 200 total reaction events, and all 200 of htem have dwell time values. The average tome is 18,140.95 milliseconds. There are 30 distinct users who reacted. 

### Question 2
I grouped reaction events by post to compare activity levels. The query showed that 13 posts had reaction events. Sorting by total events makes it much easier to identigy which posts receive more activity.

### Question 3
I used HAVING COUNT(*) >= 10 to focus on posts with at least 10 reaction events. This returned 12 posts exactly. Post 11 had the highest removal rate, being at 31.25%. I think filtering out posts with fewer events help make comparisons more meaningful.

### Question 4
I grouped the reactiosn by post and client country. This returned 62 post and region combinations. Grouping by two dimensions helps show how removal actity and average dwell time can vary across different posts and regions.

## Task 4.2
### Part A
the conditional aggregation query counted all reaction events and calculated the totals for active, flagged, and removed reactions all in one query. There were a total of 200 reactions. 156 of them were active, 10 flagged, and 34 removed. The removal rate is 71%. 

### Part B
I used ROLLUP to calculate removal stats by region and include a platform-wide total. India had the highest removal rate at 27.5%, with 11 removed events out of the 40. The US had a rate of 21.05%,  Vietname with 13.95%, Brazil with 12.82%, and the UK with 10%. The grand total confirmed the overall removal rate was 17%

### Part C
I used a CTE to basically summarize each post's total events, remove the events, and the remove rate. I then filtered high volume posts with at least 10 events. The query returned 12 high volume posts with an average removal rate of 17.03%. This provides a baseline for compring posts with sufficient activty. 

### Reflection
Conditional aggregation makes it a lot easier to get multiple results in one query instead of writing separate queries for each one. An example is that I was able to count active, flagged, and removed reactions all at once. This made it easier to compare the results and see the overall removal rate.

If I used separate queries for each status, I would have to run more queries to get the same information. With a dataset that has a million events, this could take a lot more time and require more work from the database because it may need to read the same table multiple times. The actual performance depends on how the database runs the queries, but conditional aggregation can be more efficient when calculating multiple values from the same data.

I also learned how ROLLUP can show regional totals and a platform-wide total in one result. Using a CTE helped me break the query into steps by calculating each post’s statistics first and then finding the average removal rate for posts with at least 10 reactions. These techniques made it much easier to organize the results and compare activity across different posts and regions.

