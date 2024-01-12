------ 1
-- Create a variable that stores query data about directors and order of popularity in each movie genre
With rankdirectors as 
(
    -- Select the columns 'Director Id', 'Director's Name', 'Director's Last Name', 'Movie Genre Details' 'Movie Rating'
	Select D.dir_id,D.dir_fname, D.dir_lname, G.gen_title, R.rev_stars,
  
   -- Use Window funtion to add columns to display the popular order of each movie type
	RANK() OVER (Partition by G.gen_title Order by (R.rev_starts DESC) as rank
	From director as D
	
  -- Connect table 'Movies directed by the director' 'Movies' 'Movie score' 'Movie genre' 'Movie genre details'
	Inner join movie_direction as MD ON D.dir_id = MD.dir_id
	Inner join movie as M ON MD.mov_id = M.mov_id
	Inner join rating as R ON M.mov_id = R.mov_id
	Inner join movie_genres as MG ON M.mov_id = MG.mov_id
	Inner join genres as G ON MG.gen_id = G.genid

	-- Group by columns 'Director Code', 'Director's Name', 'Director's Last Name', 'Movie Genre Details' 'Movie Rating'
	Group by D.dir_id,D.dir_fname, D.dir_lname, G.gen_title, R.rev_stars
)

-- Select the columns 'Director Code' 'Director Name' 'Director Last Name' 'Movie Genre' 'Movie Score'
Select dir_id, dir_fname, dir_lname, gen_title, rev_stars
	
-- From Variable 'rankdirectors'
From rankdirectors 

-- Choose only 1st popular directors
Where rank = '1'





------ 2
-- Select the columns "Actor Id", "Actor Name", "Actor Surname", and "Actor Gender" from the total duration of the movie 
Select A.act_id, A.act_fname, A.act_lname, A.act_gender, sum(M.movie_time) 
From actor as A

-- Connect tables 'cast' 'movie' 'movie rating'
Inner join movie_cast as MC ON A.act_id = MC.act_id
Inner join movie as M ON MC.mov_id = M.mov_id
Inner join rating as R ON M.mov_id = R.mov_id

-- Select only rows with review scores
Where R.rev_starts is not null

-- Group by columns "Actor Id", "Actor Name", "Actor Surname", and "Actor Gender"
Group by A.act_id, A.act_fname, A.act_lname, A.act_gender





------ 3
-- Select the first 5 rows, columns 'Director's Name', 'Director's Last Name', 'Actor's Name', 'Last Name' and counting all occurrences.
Select TOP 5 D.dir_fname, D.dir_lname, A.act_fname, A.act_lname,count(*) as collab_count
From director as D

-- Connect table 'movies directed by the director' 'film' 'acting' 'actors'
inner join movie_direction as MD ON D.dir_id = MD.dir_id
inner join movie as M ON MD.mov_id = M.mov_id
inner join movie_cast as MC ON MD.mov_id = MC.mov_id
inner join actor as A ON MC.act_id = A.act_id

-- Choose only female
Where act_gender = 'F'

-- Group by columns 'Director's Name', 'Director's Last Name', 'Actor's Name', 'Last Name'
Group by D.dir_fname, D.dir_lname, A.act_fname, A.act_lname

-- Sort the number of directors and actors working together in descending order
Order by collab_count DESC





------ 4
-- Change the datatype column 'gen_title' from table 'genres' from char(20) to integer
Alter table genres
Add column gen_title_new Integer

-- Create a new column named 'gen_title_new' where the value inside is a row of numbers arranged according to the name of the movie genre, for example Action:1, biography:2
Update genres
SET gen_title_new = Dense_rank() Over (Order by gen_title)

-- Delete the 'gen_title' column
Alter table genres
Drop column gen_title

-- Change the column name 'gen_title_new' to 'gen_title'
Alter table genres
Rename column gen_title_new to gen_title





------ 5
-- Update Table 'actor'
Update actor

-- Update the 'actor_gender' column to famele
SET act_gender = 'F'

-- Condition is Names starting with words like Em, Char or names ending with words like dy, sy, lia don't care about the big or small letters
WHERE LOWER(act_fname) ilike 'em%' 
OR LOWER(act_fname) ilike 'char%'
OR LOWER(act_lname) ilike '%dy' 
OR LOWER(act_lname) ilike '%sy' 
OR LOWER(act_lname) ilike '%lia'