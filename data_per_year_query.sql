/* Retrieving selected average features per year from Spotify data - 'tracks' table. */

with cte as (
	SELECT * FROM (
			SELECT  loudness,
					energy,
					danceability,
					speechiness,
					instrumentalness,
					liveness,
					valence,
					tempo,
					duration_ms,
					popularity,
					release_year = YEAR(release_date),
					ROW_NUMBER() OVER (PARTITION BY YEAR(release_date) ORDER BY popularity DESC) as track_rank  -- Order by popularity aiming to achieve an equal number of tracks for every year in which the tracks are the most popular.
			FROM tracks
			WHERE YEAR(release_date) IS NOT NULL AND YEAR(release_date) BETWEEN 1920 AND 2021
				) t
	WHERE release_year BETWEEN 1941 AND 2021 AND track_rank <= 712 -- 712 = minimum track count per year for years 1941-2021
	)

SELECT  release_year,
		loudness = AVG(loudness),
		energy = AVG(energy),
		danceability = AVG(danceability),
		speechiness = AVG(speechiness),
		instrumentalness = AVG(instrumentalness),
		liveness = AVG(liveness),
		valence = AVG(valence),
		tempo = AVG(tempo),
		duration_ms = AVG(duration_ms)
FROM cte
GROUP BY release_year
ORDER BY release_year



