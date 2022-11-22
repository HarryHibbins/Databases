2. Create Test SQL seeds

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

- Below this line there should only be `INSERT` statements.
- Replace these statements with your own seed data.

 - Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 music_library_test < spec/seeds_albums.sql

3. Define the class names 
album

4. Modle class

class Album 
   attr_accessor :id, :title, :release_year, :artist_id
end
5. Define the Repository Class interface

AlbumsRepository

- all
  # Executes the SQL query:
  * SELECT * FROM albums;

- find(id)
    # Executes the SQL query:
    * SELECT * FROM albums WHERE id = $1;

    # Returns a single album object.


- create(album)
    # Executes the SQL query:
    * INSERT INTO albums 
    (title, release_year, artist_id) 
    VALUES (album.title, album.release_year, album.artist_id)

    # Returns nothing but creates a row 

6. Example tests 

* Get all albums

repo = AlbumRepository.new
albums = repo.all
artists.length => 2

album[0].id => 1
album[0].name => Doolittle
album[0].release_year => 1989
album[0].arist_id => 1

album[1].id => 2
album[1].name => Waterloo
album[1].release_year => 1988
album[1].arist_id => 1

* Get a single student

     repo = AlbumRepository.new
    albums = repo.find(1)

    album.id => 1
    album.name => 'Waterloo'
    album.release_year => 1988
    album.arist_id => 1


