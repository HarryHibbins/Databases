TRUNCATE TABLE users, posts RESTART IDENTITY; -- replace with your own table name.


INSERT INTO users (username, email) VALUES ('username_1', 'username_1@email.com');
INSERT INTO users (username, email) VALUES ('username_2', 'username_2@email.com');


INSERT INTO posts (title, content, views) VALUES ('title_1', 'content_1', 10);
INSERT INTO posts (title, content, views) VALUES ('title_2', 'content_2', 20);