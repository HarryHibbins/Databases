  require 'artist_repository'

  def reset_artists_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  RSpec.describe ArtistRepository do
    before(:each) do 
      reset_artists_table
    end

    it 'gets 1 artist by id' do
        repo = ArtistRepository.new
        id = 1
        artist = repo.find(id)

        expect(artist.id).to eq '1'
        expect(artist.name).to eq 'Pixies'
        expect(artist.genre).to eq 'Rock'
    end

    it 'Creates an artist' do
      
      repo = ArtistRepository.new

      artist = Artist.new
      artist.name = 'Taylor Swift'
      artist.genre = 'Pop'

      repo.create(artist)

      artists = repo.all

      expect(artists).to include(
        have_attributes(
          name: artist.name,
          genre: artist.genre,
        )
      )

    end

    it 'Deletes a record' do
      repo = ArtistRepository.new
      repo.delete(1)
      artists = repo.all

      expect(artists.length).to eq 1
      expect(artists.first.id).to eq "2"
      
    end

    it 'Deletes both records' do
      repo = ArtistRepository.new
      repo.delete(1)
      repo.delete(2)
      artists = repo.all
      expect(artists.length).to eq 0

    end

    it 'gets all artists' do
      repo = ArtistRepository.new
      artists = repo.all
      expect(artists.length).to eq  2

      expect(artists[0].id).to eq "1"
      expect(artists[0].name).to eq "Pixies"
      expect(artists[0].genre).to eq "Rock"

      expect(artists[1].id).to eq '2'
      expect(artists[1].name).to eq 'ABBA'
      expect(artists[1].genre).to eq 'Pop'

    end
    
  end