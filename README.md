## Introduction
In the interview Challenge (Data Engineer Internship), I wrote a SQL Script from a movie database and I wrote a Python script retrieves data from API.

## SQL Script Documentation
### Challenge 1
Objective: Retrieve the most popular directors for each movie genre based on user ratings.

SQL Script Explanation:
The script uses a Common Table Expression (CTE) named rankdirectors to rank directors based on their popularity within each movie genre.
It employs window functions and joins multiple tables (director, movie_direction, movie, rating, movie_genres, and genres) to retrieve the necessary information.
The final SELECT statement filters the results to only include the top-ranked directors for each genre.

### Challenge 2
Objective: Calculate the total duration of movies each actor has participated in, considering only movies with non-null popularity ratings.

SQL Script Explanation:
The script joins the actor, movie_cast, movie, and rating tables to retrieve actor information and movie durations.
It uses the WHERE clause to exclude movies with null popularity ratings.
The result is grouped by actor and includes the sum of movie durations.

### Challenge 3
Objective: Identify the top 5 collaborations between directors and actresses based on the number of collaborations.

SQL Script Explanation:
The script retrieves data from the director, movie_direction, movie, movie_cast, and actor tables.
It filters only female actors and groups the data by director and actress names, counting the number of collaborations.
The result is sorted in descending order by collaboration count, and only the top 5 collaborations are selected.

### Challenge 4
Objective: Alter the genres table by adding a new column, transforming the gen_title column into integers, and reordering them alphabetically.

SQL Script Explanation:
The script adds a new column gen_title_new to the genres table.
It uses the DENSE_RANK() window function to assign integer values based on the alphabetical order of genre titles.
The original gen_title column is dropped, and the new column is renamed to gen_title.

### Challenge 5
Objective: Update the gender of actors with specific name patterns to female.

SQL Script Explanation:
The script updates the gender column in the actor table for actors with names starting or ending with specific patterns.
It uses the ILIKE operator to perform case-insensitive pattern matching.

## Python Script Documentation
### This script performs the following tasks:
1. Fetch data from a web API, process it, and store it in a Pandas DataFrame.
2. Predict gender from first names using another API and add the predictions to the DataFrame.
3. Create additional columns to compare the predicted gender with the actual gender.

### Functions:
- get_data(): Fetches user data from a random user API and returns the results.
- format_data(users): Formats user data from the API response into a structured DataFrame.
- api_predict(first_name): Calls an API to predict gender based on the provided first name.
- Main code: Fetches data, formats it, predicts gender, and compares it with the actual gender.

### Dependencies:
- requests: Library for making HTTP requests.
- pandas: Library for data manipulation and analysis.
- numpy: Library for numerical operations.




