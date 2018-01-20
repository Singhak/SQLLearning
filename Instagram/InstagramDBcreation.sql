/* Dropping the Database if it is already exist means if we run it multiple time does not give error that Database already exist*/

DROP DATABASE instagramdb;

/* Creating a instagram Database*/
CREATE DATABASE instagramdb;

/* Now we will use instagrame database to create table(s)*/
USE instagramdb;



-- USER TABLE

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    create_dt TIMESTAMP DEFAULT NOW()
);

-- PHOTOS

CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    create_dt TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

-- COMMENTS

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    create_dt TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
);

-- LIKES
CREATE TABLE likes (
    photo_id INT NOT NULL,
    user_id INT NOT NULL,
    create_dt TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

-- FOLLOWER/FOLLOWING

CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    create_dt TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    FOREIGN KEY(follower_id) REFERENCES users(id),
	/* We create a primary key with combination of follower_id and followee_id so that user cannot follow multiple times*/
    PRIMARY KEY(follower_id, followee_id) 
);

-- TAG ans PHOTO TAG

CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255),
    create_dt TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
    photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    create_dt TIMESTAMP DEFAULT NOW(),
	/* We create a primary key with combination of photo_id, tag_id so that user cannot like photo multiple times*/
    PRIMARY KEY(photo_id, tag_id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id)
);

INSERT INTO 
	users (username, create_dt) 
	VALUES 
		('Kenton_Kirlin', '2017-02-16 18:22:10.846'), 
		('Andre_Purdy85', '2017-04-02 17:11:21.417'), 
		('Harley_Lind18', '2017-02-21 11:12:32.574'), 
		('Arely_Bogan63', '2016-08-13 01:28:43.085'), 
		('Aniya_Hackett', '2016-12-07 01:04:39.298'), 
		('Travon.Waters', '2017-04-30 13:26:14.496'), 
		('Kasandra_Homenick', '2016-12-12 06:50:07.996'), 
		('Tabitha_Schamberger11', '2016-08-20 02:19:45.512'), 
		('Gus93', '2016-06-24 19:36:30.978'), 
		('Presley_McClure', '2016-08-07 16:25:48.561');


INSERT INTO 
	photos(image_url, user_id) 
	VALUES 
		('http://elijah.biz', 1), 
		('https://shanon.org', 1), 
		('http://vicky.biz', 1), 
		('http://oleta.net', 1), 
		('https://jennings.biz', 1), 
		('https://quinn.biz', 2), 
		('https://selina.name', 2), 
		('http://malvina.org', 2), 
		('https://branson.biz', 2), 
		('https://elenor.name', 3), 
		('https://marcelino.com', 3), 
		('http://felicity.name', 3),
		('https://fred.com', 3), 
		('https://gerhard.biz', 4), 
		('https://sherwood.net', 4), 
		('https://maudie.org', 4), 
		('http://annamae.name', 6), 
		('https://mac.org', 6), 
		('http://miracle.info', 6), 
		('http://emmet.com', 6), 
		('https://lisa.com', 6), 
		('https://brooklyn.name', 8), 
		('http://madison.net', 8);

		
INSERT INTO 
	follows(follower_id, followee_id)
	VALUES 
		(2, 1), 
		(2, 3), 
		(2, 4), 
		(2, 5), 
		(2, 6), 
		(2, 7), 
		(2, 8), 
		(2, 9), 
		(2, 10);
		
INSERT INTO 
	comments(comment_text, user_id, photo_id) 
	VALUES 
		('unde at dolorem', 2, 1), 
		('quae ea ducimus', 3, 1), 
		('alias a voluptatum', 5, 1), 
		('facere suscipit sunt', 4, 1), 
		('totam eligendi quaerat', 7, 1), 
		('vitae quia aliquam', 2, 1), 
		('exercitationem occaecati neque', 4, 3), 
		('sint ad fugiat', 3, 4), 
		('nesciunt aut nesciunt', 6, 1), 
		('explicabo amet voluptatem', 5, 5), 
		('expedita possimus id', 4, 12);

		 
INSERT INTO 
	likes(user_id,photo_id) 
	VALUES 
		(2, 1), 
		(5, 4), 
		(9, 1), 
		(10, 1),
		(4,2),
		(5,3),
		(3,5);
		
		
INSERT INTO 
	tags(tag_name) 
	VALUES 
		('sunset'), 
		('photography'), 
		('sunrise'), 
		('landscape'), 
		('food'), 
		('foodie'), 
		('delicious'), 
		('beauty'), 
		('stunning'), 
		('dreamy'),
		("lol"),
		("happy");
		
INSERT INTO 
	photo_tags(photo_id, tag_id) 
	VALUES 
		(1, 1), (1, 7), 
		(1, 2), (1, 3), 
		(1, 9), (2, 4), 
		(2, 3), (2, 2), 
		(2, 7), (3, 8), 
		(4, 12),(4, 11), 
		(4, 1), (4, 3), 
		(5, 5), (5, 10), 
		(5, 7), (5, 1), 
		(6, 9), (6, 3), 
		(6, 7), (6, 4), 
		(7, 11), (7, 12), 
		(7, 1), (7, 3), 
		(8, 7), (3,5);