-- Select top 2 old users

SELECT
	users.username AS user_name,
	users.create_dt AS join_date
FROM users
ORDER BY users.create_dt
LIMIT 2;

-- Result
+-----------------+---------------------+
| user_name       | join_date           |
+-----------------+---------------------+
| Gus93           | 2016-06-24 19:36:30 |
| Presley_McClure | 2016-08-07 16:25:48 |
+-----------------+---------------------+

-- Count number of user join on each days

SELECT
	DAYNAME(users.create_dt) AS days,
	COUNT(*) AS user_count
FROM users
GROUP BY days
ORDER BY user_count DESC;

-- Result
+-----------+------------+
| days      | user_count |
+-----------+------------+
| Sunday    |          3 |
| Saturday  |          2 |
| Wednesday |          1 |
| Monday    |          1 |
| Friday    |          1 |
| Thursday  |          1 |
| Tuesday   |          1 |
+-----------+------------+

-- Select user who did not like any photos

SELECT 
	users.username
FROM users
LEFT JOIN likes
	ON 1=1
	AND users.id = likes.user_id
WHERE 1=1
	AND likes.photo_id IS NULL; /* Those user who did not like any photo for them photo id is null*/

-- Result

+-----------------------+
| username              |
+-----------------------+
| Kasandra_Homenick     |
| Kenton_Kirlin         |
| Tabitha_Schamberger11 |
| Travon.Waters         |
+-----------------------+

-- Select those user who did not post any photo

SELECT 
	users.username
FROM users
LEFT JOIN photos
	ON 1=1
	AND users.id = photos.user_id
WHERE 1=1
	AND photos.id IS NULL;
	
-- Result

+-------------------+
| username          |
+-------------------+
| Aniya_Hackett     |
| Gus93             |
| Kasandra_Homenick |
| Presley_McClure   |
+-------------------+

-- Select user and their post counts

SELECT
	users.username AS name,
	COUNT(*) AS post_count
FROM users
INNER JOIN photos
	ON 1=1
	AND users.id = photos.user_id
GROUP BY name
ORDER BY post_count DESC;

--Result

+-----------------------+------------+
| name                  | post_count |
+-----------------------+------------+
| Travon.Waters         |          5 |
| Kenton_Kirlin         |          5 |
| Harley_Lind18         |          4 |
| Andre_Purdy85         |          4 |
| Arely_Bogan63         |          3 |
| Tabitha_Schamberger11 |          2 |
+-----------------------+------------+

-- Select Top 5 tags which are used

SELECT 
	tags.tag_name,
	COUNT(*) AS tag_count
FROM tags
INNER JOIN photo_tags
	ON 1=1
	AND tags.id = photo_tags.tag_id
GROUP BY tags.tag_name
ORDER BY tag_count DESC;

-- Result

+-------------+-----------+
| tag_name    | tag_count |
+-------------+-----------+
| sunrise     |         5 |
| delicious   |         5 |
| sunset      |         4 |
| happy       |         2 |
| photography |         2 |
| landscape   |         2 |
| food        |         2 |
| stunning    |         2 |
| lol         |         2 |
| beauty      |         1 |
| dreamy      |         1 |
+-------------+-----------+

-- Find bots means find those user who like every photo

SELECT
	users.username,
	COUNT(*) AS like_count
FROM users
INNER JOIN likes
	ON 1=1
	AND users.id = likes.user_id
GROUP BY users.username
HAVING 1=1
	AND like_count = (
		SELECT 
			COUNT(*) /* Number of photo count should be equal to user like count to declare a user bot*/
		FROM photos
	);
	
-- Result
Empty set

-- Select photos and photo owner and likes counts

SELECT
	photos.image_url AS image,
	users.username AS owner,
	--COUNT(*) likes_count
FROM photos
INNER JOIN users
	ON 1=1
	AND photos.user_id = users.id
INNER JOIN likes
	ON 1=1
	AND photos.id = likes.photo_id
GROUP BY image
ORDER BY likes_count DESC;

-- Result

+----------------------+---------------+-------------+
| image                | owner         | likes_count |
+----------------------+---------------+-------------+
| http://elijah.biz    | Kenton_Kirlin |           3 |
| https://jennings.biz | Kenton_Kirlin |           1 |
| http://vicky.biz     | Kenton_Kirlin |           1 |
| http://oleta.net     | Kenton_Kirlin |           1 |
| https://shanon.org   | Kenton_Kirlin |           1 |
+----------------------+---------------+-------------+

-- Select those top 5 photos who got most comment

SELECT
	photos.image_url AS photo,
	COUNT(*) AS comment_count
FROM photos
INNER JOIN comments
	ON 1=1
	AND photos.id = comments.photo_id
GROUP BY photo
ORDER BY comment_count DESC;

-- Result

+----------------------+---------------+
| photo                | comment_count |
+----------------------+---------------+
| http://elijah.biz    |             7 |
| http://vicky.biz     |             1 |
| http://oleta.net     |             1 |
| https://jennings.biz |             1 |
| http://felicity.name |             1 |
+----------------------+---------------+

-- Find the photos which got comment but not likes

SELECT
	photos.image_url AS photo
FROM photos
INNER JOIN comments
	ON 1=1
	AND photos.id = comments.photo_id
LEFT JOIN likes /* Left join help to get all photos from left and so it is easy to find not liked photo because for those phot which have no like for those all values is NULL in likes table*/
	ON 1=1
	AND photos.id = likes.photo_id
WHERE likes.photo_id IS NULL;
GROUP BY photo;

-- Result

+----------------------+
| photo                |
+----------------------+
| http://felicity.name |
+----------------------+


-- Find the photos which got likes but not comments

SELECT
	photos.image_url AS photo
FROM photos
INNER JOIN comments
	ON 1=1
	AND photos.id = comments.photo_id
RIGHT JOIN likes /* RIGHT join help to get all photos from left and so it is easy to find without comment photo because for those photo which have no comment for those all values is NULL in comments table*/
	ON 1=1
	AND photos.id = likes.photo_id
WHERE comments.photo_id IS NULL;
GROUP BY photo;

-- Result
+-------+
| photo |
+-------+
| NULL  |
+-------+