2. Create Test SQL seeds

TRUNCATE TABLE Posts RESTART IDENTITY; -- replace with your own table name.

- Below this line there should only be `INSERT` statements.
- Replace these statements with your own seed data.

INSERT INTO Posts (title, content, views) VALUES ('title_1', 'content_1', 10);
INSERT INTO Posts (title, content, views) VALUES ('title_2', 'content_2', 20);


 - Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network_test < spec/seeds_posts.sql

3. Define the class names 
Post

4. Modle class

class Post 
   attr_accessor :id, :title, :content, :views
end
5. Define the Repository Class interface

PostRepository

- all
  # Executes the SQL query:
  sql = 'SELECT * FROM posts;'


- find(id)
  # Executes the SQL query:
  sql = 'SELECT * FROM posts WHERE id = $1;'


- create(post)

  sql = 'INSERT INTO posts (title, content, views) VALUES ($1, $2, $3);'

- delete(id)

sql = 'DELETE FROM posts WHERE id = $1;'

   


6. Example tests 

* 1. return all posts
repo = PostRepository.new
posts = repo.all

expect(posts.length) #=> 2

expect(posts[0].title).to eq 'title_1'
expect(posts[0].content).to eq 'content_1'
expect(posts[0].views).to eq '10'
expect(posts[1].title).to eq 'title_2'
expect(posts[1].content).to eq 'content_2'
expect(posts[1].views).to eq '20'


* 2. find a specific post

repo = PostRepository.new
post = repo.find(2)

expect(post.title).to eq 'title_2'
expect(post.content).to eq 'content_2'
expect(post.views).to eq '20'

* 3. Create a new post

repo = PostRepository.new #Create our new repo class

#Create our new post

new_post = Post.new
new_post.title = 'title_3'
new_post.content = 'content_3'
new_post.views = 30
repo.create(new_post)

#Call all method on postrepository
posts = repo.all

expect(posts.length) #=> 3
expect(posts[2].title).to eq 'title_3'
expect(posts[2].content).to eq 'content_3'
expect(posts[2].views).to eq '30'

* 4 Delete a post

repo = PostRepository.new #Create our new repo class
repo.delete(1)
posts = repo.all
expect(posts.length).to eq 1
expect(posts[0].title).to eq 'title_2'




7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end