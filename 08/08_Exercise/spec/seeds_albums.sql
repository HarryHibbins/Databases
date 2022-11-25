-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

TRUNCATE TABLE albums, artists RESTART IDENTITY; -- replace with your own table name.


INSERT INTO albums (title, release_year, artist_id) VALUES ('Doolittle', 1989, 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Waterloo', 1988, 1);
INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES ('ABBA', 'Pop');
