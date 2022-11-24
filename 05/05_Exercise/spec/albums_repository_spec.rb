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


    
  end