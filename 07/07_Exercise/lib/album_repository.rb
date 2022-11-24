require_relative './album'

class AlbumRepository

    def all 
       sql = 'SELECT * FROM albums;'
       result = DatabaseConnection.exec_params(sql, [])

       albums = []

       result.each do |record|
        album = Album.new
        album.id = record['id']
        album.title = record['title']
        album.release_year = record['release_year']
        album.artist_id = record['artist_id']

        albums << album
       end

       return albums

    end

    def find(id)

        sql = 'SELECT * FROM albums WHERE id = $1;'

        params = [id]
        
        result = DatabaseConnection.exec_params(sql, params)

        album = Album.new
        album.id = result[0]['id']
        album.title = result[0]['title']
        album.release_year = result[0]['release_year']
        album.artist_id = result[0]['artist_id']
        p album

        return album
    end

    def create(album)
        sql = 'INSERT INTO albums
        (title, release_year, artist_id)
        VALUES ($1, $2, $3)'

        params = [album.title, album.release_year, album.artist_id]
        result = DatabaseConnection.exec_params(sql, params)    
        return nil

    end

    def delete(id)
        sql = 'DELETE FROM albums WHERE id = $1'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)    
        return nil
    end
end