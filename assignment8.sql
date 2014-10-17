--Deliverable 1) URL:http://googleblog.blogspot.co.uk/
--Deliverable 2) entity-relationship diagram: https://github.com/adamstopek/CunyMSDA/blob/DataAquisition/20141017_182923.jpg
--Deliverable 3) Implement DB
-- Create DB
CREATE DATABASE blogs
WITH OWNER = postgres
ENCODING = 'UTF8'
TABLESPACE = "IS607"
LC_COLLATE = 'English_United States.1252'
LC_CTYPE = 'English_United States.1252'
CONNECTION LIMIT = -1;
-- Create tables
-- The first table has one row per blog with some metadata (url, title, author)
CREATE TABLE blog_posts
( 
   blog_id bigint NOT NULL,
   blog_title text NOT NULL, 
   blog_url text NOT NULL,
   blog_author text   
) 
;
-- The second table has one row per tag per blog
CREATE TABLE blog_tags
(
   blog_id bigint,
   tag text NOT NULL
) 
;
-- The third table has on row per comment per blog 
CREATE TABLE blog_comments
(
   blog_id bigint,
   comment text NOT NULL
) 
;

--Deliverable 4) Populate DB
-- Insert data into tables:
INSERT INTO blog_posts VALUES
(1,'Android: Be together. Not the same', 'http://googleblog.blogspot.co.uk/2014/10/android-be-together-not-same.html','Sundar Pichai'),
(2,'OMG! Mobile voice survey reveals teens love to talk','http://googleblog.blogspot.co.uk/2014/10/omg-mobile-voice-survey-reveals-teens.html','Scott Huffman'),
(3, 'Google Express: more cities, more stores and a new name','http://googleblog.blogspot.co.uk/2014/10/google-express-more-cities-more-stores.html', 'Brian Elliott');
INSERT INTO blog_tags VALUES
(1, 'android'),
(1, 'nexus'),
(1, 'lollipop'),
(1, 'mobile'),
(2, 'mobile'),
(2, 'search'),
(3, 'shopping');
INSERT INTO blog_comments VALUES
(1, 'yay'),
(1, 'way to go'),
(1, 'I hate android ios is better'),
(2, 'very interesting'),
(2, 'I cant believe that teens like to talk'),
(3, 'shopping is fun');

--Deliverable 5) Queries and results
--  SQL query that returns all of the blog posts, with associated comments and tags
-- this query uses array_agg to aggregate all the tags into a single array as well as all the comments into a single array
-- the reason for this is because we want only one row per blog post to return from the query
SELECT blog_posts.blog_title,  
ARRAY_AGG(distinct blog_tags.tag) as tags,
ARRAY_AGG(distinct blog_comments.comment) as comments 
FROM blog_posts,
blog_tags,
blog_comments
WHERE blog_posts.blog_id = blog_tags.blog_id
AND blog_posts.blog_id = blog_comments.blog_id
GROUP BY blog_posts.blog_title ;

-- RESULTS (columns seperated by ';')
--"Android: Be together. Not the same";"{android,lollipop,mobile,nexus}";"{"I hate android ios is better","way to go",yay}"
--"Google Express: more cities, more stores and a new name";"{shopping}";"{"shopping is fun"}"
--"OMG! Mobile voice survey reveals teens love to talk";"{mobile,search}";"{"I cant believe that teens like to talk","very interesting"}"


-- SQL query that returns all of the posts for a given tag
-- Similar to the query above, we now group all the blog titles that have a specific tag into a single array.
SELECT blog_tags.tag as tag,  
ARRAY_AGG(blog_posts.blog_title) as posts
FROM blog_posts,
blog_tags
WHERE blog_posts.blog_id = blog_tags.blog_id
GROUP BY 1 ;

--RESULTS (columns seperated by ';')
--"android";"{"Android: Be together. Not the same"}"
--"lollipop";"{"Android: Be together. Not the same"}"
--"mobile";"{"Android: Be together. Not the same","OMG! Mobile voice survey reveals teens love to talk"}"
--"nexus";"{"Android: Be together. Not the same"}"
--"search";"{"OMG! Mobile voice survey reveals teens love to talk"}"
--"shopping";"{"Google Express: more cities, more stores and a new name"}"



