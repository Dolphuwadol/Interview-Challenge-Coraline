## Introduction
In the interview Challenge (Data Engineer Internship), I wrote a SQL Script from a movie database and I wrote a Python script retrieves data from API.

## SQL Script
ER-diagram movie Database
![Screenshot 2024-01-12 133029](https://github.com/Dolphuwadol/Interview-Challenge-Coraline/assets/121854744/50c0696f-a33f-450b-bf98-f37c0f057f84)
Write an sql script with the 5 assigned questions
1. Display the most popular directors in each movie category.
2. Display information. How long did each actor perform in total? The popularity score is not empty.
3. Display the number of collaborations between the director and actress through the following methods: Only the top 5 actresses who collaborate with the director the most frequently
4. Change the gen_title type from char (20) to an integer arranged alphabetically, such as an action.Convert to 1, animation to 2, biography to 3...
5. Edit the gender of the actor Names starting with the words Em, Char or ending with the words dy, sy, lia are female, regardless of small or large sizes.


## Python Script
1. Select 20 users in the system by calling the API and collecting data from https://randomuser.me/api
![Screenshot 2024-01-12 122814](https://github.com/Dolphuwadol/Interview-Challenge-Coraline/assets/121854744/817480f1-e216-45bb-825a-1fe7773a8690)

2-3. Call the API to predict the gender of the user in step 1 and store the data. Gender and Probability.Check the match between the gender from the system and the predicted gender from https://api.genderize.io/?name=

![Screenshot 2024-01-12 130835](https://github.com/Dolphuwadol/Interview-Challenge-Coraline/assets/121854744/c4b3ceeb-0a47-4c92-9776-4332241e2ee4)
