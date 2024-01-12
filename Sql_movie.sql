------ 1
-- Create a variable that stores query data about directors and order of popularity in each movie genre
With rankdirectors as 
(
	Select D.dir_id,D.dir_fname, D.dir_lname, G.gen_title, R.rev_stars,
  
   -- Use Window funtion to add columns to display the popular order of each movie type
	RANK() OVER (Partition by G.gen_title Order by (R.rev_starts DESC) as rank
	From director as D
	
	Inner join movie_direction as MD ON D.dir_id = MD.dir_id
	Inner join movie as M ON MD.mov_id = M.mov_id
	Inner join rating as R ON M.mov_id = R.mov_id
	Inner join movie_genres as MG ON M.mov_id = MG.mov_id
	Inner join genres as G ON MG.gen_id = G.genid

	Group by D.dir_id,D.dir_fname, D.dir_lname, G.gen_title, R.rev_stars
)

Select dir_id, dir_fname, dir_lname, gen_title, rev_stars
	
From rankdirectors 

-- Choose only 1st popular directors
Where rank = '1'


------ 2
Select A.act_id, A.act_fname, A.act_lname, A.act_gender, sum(M.movie_time) 
From actor as A

Inner join movie_cast as MC ON A.act_id = MC.act_id
Inner join movie as M ON MC.mov_id = M.mov_id
Inner join rating as R ON M.mov_id = R.mov_id

-- Select only rows with review scores
Where R.rev_starts is not null

Group by A.act_id, A.act_fname, A.act_lname, A.act_gender


------ 3
Select TOP 5 D.dir_fname, D.dir_lname, A.act_fname, A.act_lname,count(*) as collab_count
From director as D

inner join movie_direction as MD ON D.dir_id = MD.dir_id
inner join movie as M ON MD.mov_id = M.mov_id
inner join movie_cast as MC ON MD.mov_id = MC.mov_id
inner join actor as A ON MC.act_id = A.act_id

-- Choose only female
Where act_gender = 'F'

Group by D.dir_fname, D.dir_lname, A.act_fname, A.act_lname

-- Sort the number of directors and actors working together in descending order
Order by collab_count DESC


------ 4
Alter table genres
Add column gen_title_new Integer

-- 'gen_title_new' = row of numbers arranged according to the name of the movie genre, for example Action:1, biography:2
Update genres
SET gen_title_new = Dense_rank() Over (Order by gen_title)

Alter table genres
Drop column gen_title

Alter table genres
Rename column gen_title_new to gen_title


------ 5
Update actor
SET act_gender = 'F'

-- Condition is a name that starts with a term, ignoring uppercase or lowercase letters
WHERE LOWER(act_fname) ilike 'em%' 
OR LOWER(act_fname) ilike 'char%'
OR LOWER(act_lname) ilike '%dy' 
OR LOWER(act_lname) ilike '%sy' 
OR LOWER(act_lname) ilike '%lia'