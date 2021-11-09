/* Outputs the active artist count per year.
	* active artists = artists that published a track during the year mentioned. */
SELECT  release_year = YEAR(t.release_date),
		active_artists = COUNT(DISTINCT a.id)
FROM tracks t
JOIN artists a ON a.id = t.id_artists
WHERE YEAR(t.release_date) IS NOT NULL AND YEAR(t.release_date) BETWEEN 1921 AND 2021
GROUP BY YEAR(t.release_date)
ORDER BY 1

/* Outputs artist data per year: id, name, and followers.
	The data is ordered by descending followers count per year in which the artist published a track during it.  */
SELECT  DISTINCT release_year = YEAR(t.release_date),
		a.id,
		a.name,
		a.followers
FROM tracks t
RIGHT JOIN artists a ON a.id = t.id_artists
WHERE YEAR(t.release_date) IS NOT NULL
ORDER BY release_year, a.followers DESC
