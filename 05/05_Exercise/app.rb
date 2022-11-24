require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

album_repository = AlbumRepository.new

album =  album_repository.find(3)
puts album.id
puts album.title
puts album.release_year
puts album.artist_id