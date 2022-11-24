require_relative './database_connection'
require_relative './post'

class PostRepository
    def all
        sql = 'SELECT * FROM posts;'
        result = DatabaseConnection.exec_params(sql, [])

        posts = []
        result.each do |record|
            post = Post.new
            post.id = record['id']
            post.title = record['title']
            post.content = record['content']
            post.views = record['views']
            post.username_id = record['username_id']
            posts << post
        end
        return posts
    end

    def find(id)
        sql = 'SELECT * FROM posts WHERE id = $1;'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)
        post = result[0]

        found_post = Post.new
        found_post.id = post['id']
        found_post.title = post['title']
        found_post.content = post['content']
        found_post.views = post['views']
        found_post.username_id = post['username_id']
        return found_post
    end

    def create(post)
        sql = 'INSERT INTO posts (title, content, views) VALUES ($1, $2, $3);'
        params = [post.title, post.content, post.views]
        DatabaseConnection.exec_params(sql, params)
        return nil

    end

    def delete(id)
        sql = 'DELETE FROM posts WHERE id = $1;'
        params = [id]
        DatabaseConnection.exec_params(sql, params)
        return nil
    end
end