require_relative './artist'

class ArtistRepository

    def all 
       sql = 'SELECT * FROM artists;'
       result = DatabaseConnection.exec_params(sql, [])

       artists = []

       result.each do |record|
        artist = Artist.new
        artist.id = record['id']
        artist.name = record['name']
        artist.genre = record['genre']

        artists << artist
       end

       return artists

    end

    def find(id)

        sql = 'SELECT * FROM artists WHERE id = $1;'

        params = [id]
        
        result = DatabaseConnection.exec_params(sql, params)

        artist = Artist.new
        artist.id = result[0]['id']
        artist.name = result[0]['name']
        artist.genre = result[0]['genre']

        return artist
    end

    def create(artist)
        sql = 'INSERT INTO artists
        (name, genre)
        VALUES ($1, $2)'

        params = [artist.name, artist.genre]
        result = DatabaseConnection.exec_params(sql, params)    
        return nil

    end

    def delete(id)
        sql = 'DELETE FROM artists WHERE id = $1'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)    
        return nil
    end
end