require_relative '../app'

RSpec.describe Application do
    it 'given choice 1 it lists all albums' do
        io = double(:io)
        expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
        expect(io).to receive(:puts).with("What would you like to do?").ordered
        expect(io).to receive(:puts).with("1 - List all albums").ordered
        expect(io).to receive(:puts).with("2 - List all artists").ordered
        expect(io).to receive(:puts).with("Enter your choice: ").ordered
        expect(io).to receive(:gets).and_return(1)

        expect(io).to receive(:puts).with("* 1 - Doolittle").ordered
        expect(io).to receive(:puts).with("* 2 - Waterloo").ordered

        app = Application.new(
            'music_library_test',
            io,
            AlbumRepository.new,
            ArtistRepository.new
          )
          app.run
    end

    it 'given choice 1 it lists all artists' do
        io = double(:io)
        expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
        expect(io).to receive(:puts).with("What would you like to do?").ordered
        expect(io).to receive(:puts).with("1 - List all albums").ordered
        expect(io).to receive(:puts).with("2 - List all artists").ordered
        expect(io).to receive(:puts).with("Enter your choice: ").ordered
        expect(io).to receive(:gets).and_return(2)

        expect(io).to receive(:puts).with("* 1 - Pixies").ordered
        expect(io).to receive(:puts).with("* 2 - ABBA").ordered

        app = Application.new(
            'music_library_test',
            io,
            AlbumRepository.new,
            ArtistRepository.new
          )
          app.run
    end
end