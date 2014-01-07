course-parser
=============

Course timetable algorithm:

1. Generate a valid (random) timetable
2. Iterate n times on initial timetable with each step being an improvement
  -> Improvement defined by score from function, the only metric being considered now is the space between classes (less space = better score)
  -> Function can be modified in the future to add additional metrics
3. Stop after n iterations or when timetable cannot be improved
4. Will not get optimal, but should be close enough
