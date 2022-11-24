require 'user_repository'

def reset_users_table
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
end
  
describe UserRepository do
    before(:each) do 
      reset_users_table
    end
  
    it "Returns a list of all users" do
        repo = UserRepository.new
        users = repo.all
        expect(users.length).to eq 2
        expect(users[0].username).to eq 'username_1'
        expect(users[0].email).to eq 'username_1@email.com'
        expect(users[1].username).to eq 'username_2'
        expect(users[1].email).to eq 'username_2@email.com'
    end

    it "Can find a User by id" do
        repo = UserRepository.new
        user = repo.find(2)
        expect(user.id).to eq '2'
        expect(user.username).to eq 'username_2'
        expect(user.email).to eq 'username_2@email.com'
    end

    it "Can create a new instance of User" do
        repo = UserRepository.new #Create our new repo class
        #Create our new user 
        new_user = User.new
        new_user.username = 'username_3'
        new_user.email = 'username_3@email.com'
        repo.create(new_user)
        #Call all method on userrepository
        users = repo.all
        expect(users.length).to eq 3
        expect(users[2].username).to eq 'username_3'
        expect(users[2].email).to eq 'username_3@email.com'
    end

    it "Can delete an User object from the table of Users" do
        repo = UserRepository.new #Create our new repo class
        repo.delete(1)
        users = repo.all
        expect(users.length).to eq 1
        expect(users[0].username).to eq 'username_2'
    end
end
