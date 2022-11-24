require_relative './database_connection'
require_relative './user'

class UserRepository
    def all
        sql = 'SELECT * FROM users;'
        results = DatabaseConnection.exec_params(sql,[])
        users = []
        results.each do |record|
            user = User.new
            user.username = record['username']
            user.email = record['email']
            users << user
        end
        return users
    end

    def find(id)
        sql = 'SELECT * FROM users WHERE id = $1;'
        params = [id]
        results = DatabaseConnection.exec_params(sql, params)
        found_user = results[0]
        

        user = User.new
        user.id = found_user['id']
        user.username = found_user['username']
        user.email = found_user['email']

        return user
    end

    def create(user)
        sql = 'INSERT INTO users (username, email) VALUES ($1, $2);'
        params = [user.username, user.email]
        DatabaseConnection.exec_params(sql, params)

        return nil

    end

    def delete(id)
        sql = 'DELETE FROM users WHERE id = $1;'
        params = [id]
        DatabaseConnection.exec_params(sql, params)

    end
end