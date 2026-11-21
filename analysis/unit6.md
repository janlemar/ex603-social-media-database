# Task 6.1

I wanted to see how each like event's dwell time compares to the average dwell time for its post. Using a window function lets me see every individual event alongside its post's average dwell time. The window query returns 200 rows, while the GROUP BY version only returns 15 rows, one for each post. This means the GROUP BY version loses the individual event details, making it harder to identify which specific events had unusually high or low dwell times.

A feature that could use ranking is a leaderboard showing posts with the most engagement. ROW_NUMBER() gives every post a unique position, while RANK() and DENSE_RANK() allow posts with the same number of events to share a rank. I would use DENSE_RANK() because posts with the same number of events should be treated equally, without skipping ranking positions after a tie.

The NTILE(4) function also divides the posts into four groups based on their event counts. One thing I noticed is that posts with the same number of events can end up in different groups when they fall on opposite sides of a quartile boundary.

# Task 6.2

## part A

A large change in dwell time between consecutive events could mean that users are spending significantly more or less time engaging with a particular post. I used LAG() and LEAD() to compare each event with the previous and next event for Post 6. This helps identify changes in engagement between individual events and could help the platform investigate what might be causing those differences.

## Part B

I think the running total helps me see how dwell time builds up across events instead of just looking at the final total. The final running total was 3,628,190 milliseconds, which exceeded my 2,000,000-millisecond target by 1,628,190 milliseconds.

I chose a three-event moving average to make changes in dwell time easier to follow without focusing too much on individual events. A smaller window reacts more quickly to changes, while a larger window smooths out more variation. ROWS counts individual records in the window, while RANGE groups rows with the same ordering value together.

## Part C

I found several gaps between like events on the same post. The largest gap was approximately 112 days and 13 hours for Post 9. This could mean there was a real break in user engagement, but I'm not sure if it is also a data limitation. Since the dataset only shows recorded events, I can't tell whether users actually stopped engaging with the post or whether some activity is missing.

# Task 6.3

## Part A

I think a feature that could use this query is a leaderboard showing the top three engagement events for each post. I used dwell time as the metric because it helps identify which individual events had the most user engagement. I chose three because it gives the platform a few important events to highlight instead of showing only one or overwhelming users with too many results. I also used RANK() so events with the same dwell time can receive equal rankings. If there is a tie at third place, all events sharing that rank are included.

## Part B

A large month-over-month change could mean that user engagement is increasing or dropping. For example, the number of events dropped by 47.62% from February to March, while it increased by 54.55% from April to May. I would investigate what caused these changes and whether they were related to content, user activity, or missing data before deciding what changes the platform should make.

In addition, I also included a check for missing months because LAG() compares the previous available row, not necessarily the previous calendar month. For my results, all 12 months from January through December 2023 were present, so there were no missing months in the period covered by the data.


# Unit 6 Reflection

One thing I definitely learned from working with window functions is how useful they are when I want to compare individual records without losing the rest of the data. For example, in my social media database, I wanted to see how each like event's dwell time compared to the average for its post. Using GROUP BY alone would only show the average for each post, but a window function allowed me to see every event alongside its post's average.

I also found window functions useful for tracking engagement over time. Using LAG(), LEAD(), running totals, and moving averages helped me understand how dwell time changed between events. I was also able to identify gaps between recorded events and compare monthly engagement across the dataset.

Overall, window functions definitely made it easier to look beyond simple totals and understand individual event performance and larger trends. They helped me answer questions that would be more difficult to answer using GROUP BY alone because I could keep the original rows while adding comparisons and calculations.