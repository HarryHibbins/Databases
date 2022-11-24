  require 'album_repository'

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  RSpec.describe AlbumRepository do
    before(:each) do 
      reset_albums_table
    end
  
    # (your tests will go here).

    it 'gets all albums' do
        repo = AlbumRepository.new
        albums = repo.all
        expect(albums.length).to eq  2

        expect(albums[0].id).to eq "1"
        expect(albums[0].title).to eq "Doolittle"
        expect(albums[0].release_year).to eq "1989"
        expect(albums[0].artist_id).to eq "1"

        expect(albums[1].id).to eq '2'
        expect(albums[1].title).to eq 'Waterloo'
        expect(albums[1].release_year).to eq '1988'
        expect(albums[1].artist_id).to eq '1'

    end

    it 'gets 1 album by id' do
        repo = AlbumRepository.new
        id = 1
        album = repo.find(id)

        expect(album.id).to eq '1'
        expect(album.title).to eq 'Doolittle'
        expect(album.release_year).to eq '1989'
        expect(album.artist_id).to eq '1'
    end

    it 'Creates an album' do
      
      repo = AlbumRepository.new

      album = Album.new
      album.title = 'Head Carrier'
      album.release_year = '2016'
      album.artist_id = '1'

      repo.create(album)

      albums = repo.all

      expect(albums).to include(
        have_attributes(
          title: album.title,
          release_year: album.release_year,
          artist_id: album.artist_id,
        )
      )

      # expect(albums[0].id).to eq "1"
      # expect(albums[0].title).to eq "Doolittle"
      # expect(albums[0].release_year).to eq "1989"
      # expect(albums[0].artist_id).to eq "1"

      # expect(albums[1].id).to eq '2'
      # expect(albums[1].title).to eq 'Waterloo'
      # expect(albums[1].release_year).to eq '1988'
      # expect(albums[1].artist_id).to eq '1'

      # expect(albums[2].id).to eq '3'
      # expect(albums[2].title).to eq 'Head Carrier'
      # expect(albums[2].release_year).to eq '2016'
      # expect(albums[2].artist_id).to eq '1'
    end

    it 'Deletes a record' do
      repo = AlbumRepository.new
      repo.delete(1)
      albums = repo.all

      expect(albums.length).to eq 1
      expect(albums.first.id).to eq "2"
      
    end

    it 'Deletes both records' do
      repo = AlbumRepository.new
      repo.delete(1)
      repo.delete(2)
      albums = repo.all
      expect(albums.length).to eq 0

    end
    
  end