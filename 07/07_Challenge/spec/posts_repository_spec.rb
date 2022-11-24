require 'post_repository'

def reset_posts_table
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
end
  
describe PostRepository do
    before(:each) do 
      reset_posts_table
    end
  
    it 'returns all posts' do
        repo = PostRepository.new
        posts = repo.all

        expect(posts.length).to eq 2

        expect(posts[0].title).to eq 'title_1'
        expect(posts[0].content).to eq 'content_1'
        expect(posts[0].views).to eq '10'
        expect(posts[1].title).to eq 'title_2'
        expect(posts[1].content).to eq 'content_2'
        expect(posts[1].views).to eq '20'
    end


    it 'finds a specific post' do

        repo = PostRepository.new
        post = repo.find(2)

        expect(post.title).to eq 'title_2'
        expect(post.content).to eq 'content_2'
        expect(post.views).to eq '20'
    end

    it 'Creates a new post' do

        repo = PostRepository.new #Create our new repo class
        #Create our new post
        new_post = Post.new
        new_post.title = 'title_3'
        new_post.content = 'content_3'
        new_post.views = 30
        repo.create(new_post)

        #Call all method on postrepository
        posts = repo.all

        expect(posts.length).to eq 3
        expect(posts[2].title).to eq 'title_3'
        expect(posts[2].content).to eq 'content_3'
        expect(posts[2].views).to eq '30'

    end

    it 'Deletes a post' do

        repo = PostRepository.new #Create our new repo class
        repo.delete(1)
        posts = repo.all
        expect(posts.length).to eq 1
        expect(posts[0].title).to eq 'title_2'
    end
end