SELECT *
 FROM `banded-scion-335914.DisneyMovies.TotalGross` 


--TOP 10 Movies (Gross)
 SELECT movie_title, release_date, genre, total_gross
 FROM `banded-scion-335914.DisneyMovies.TotalGross` 
 --GROUP BY 2,1,3
 ORDER BY 4 DESC
 LIMIT 10

-- Worst 10 Movies (Gross)
 SELECT movie_title, release_date, genre, total_gross
 FROM `banded-scion-335914.DisneyMovies.TotalGross`
 WHERE total_gross > 0
 --GROUP BY 2,1,3
 ORDER BY 4 ASC
 LIMIT 10

--Total Gross All Time
SELECT  COUNT(movie_title) AS Movies,SUM(total_gross) AS TotalGross
 FROM `banded-scion-335914.DisneyMovies.TotalGross`


--Lets Break It Down By Year
SELECT  EXTRACT(YEAR FROM release_date) AS ReleaseYear,Sum(total_gross) AS TotalGross, COUNT(movie_title) AS Movies
 FROM `banded-scion-335914.DisneyMovies.TotalGross` 
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 10

-- AVG OF Gross Of a Movie Each Year
WITH Percentage
AS
(
SELECT  EXTRACT(YEAR FROM release_date) AS ReleaseYear,Sum(total_gross) AS TotalGross, COUNT(movie_title) AS Movies
 FROM `banded-scion-335914.DisneyMovies.TotalGross` 
 WHERE total_gross IS NOT NULL
 GROUP BY 1
 ORDER BY 1 DESC
 --LIMIT 10
)
SELECT *,ROUND(TotalGross/Movies,0) AS AvgGrossYear
FROM Percentage 
ORDER BY AvgGrossYear DESC 

--Lets Break It Down By Month
SELECT  EXTRACT(Month FROM release_date) AS ReleaseYear,Sum(total_gross) AS TotalGross, COUNT(movie_title) AS Movies
 FROM `banded-scion-335914.DisneyMovies.TotalGross` 
 GROUP BY 1
 ORDER BY 2 DESC

 --AVG Movie Per Month
 WITH AVMM
 AS
 (
 SELECT  EXTRACT(Month FROM release_date)AS ReleaseYear,Sum(total_gross) AS TotalGross, COUNT(movie_title) AS Movies
 FROM `banded-scion-335914.DisneyMovies.TotalGross` 
 GROUP BY 1
 ORDER BY 2 DESC
 )
 SELECT *,Round(TotalGross/Movies,0)  AS AVGMoviePerMonth
 FROM AVMM
 ORDER BY AVGMoviePerMonth DESC 


 -- Lets Break It Down by Genre
 SELECT genre, Sum(total_gross) AS TotalGross
 FROM `banded-scion-335914.DisneyMovies.TotalGross` 
 GROUP BY 1
 ORDER BY 2 DESC
 
 
 --Top Movie In Each Genre
SELECT D2.genre, D1.movie_title,D2.TotalGross  
FROM `banded-scion-335914.DisneyMovies.TotalGross` D1
JOIN 
 (
   SELECT MAX(total_gross) AS TotalGross, genre
 FROM `banded-scion-335914.DisneyMovies.TotalGross` 
  GROUP BY 2
 ) D2
ON D1.genre = D2.genre
 AND D1.total_gross = D2.TotalGross
 ORDER BY 3 DESC
