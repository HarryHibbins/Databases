require_relative './book'

class BookRepository

    # Selecting all records
    # No arguments
    def all
      sql = 'SELECT * FROM books;'
      result = DatabaseConnection.exec_params(sql, [])

      books = []

      result.each do |record|
        book = Book.new

        book.id = record['id']
        book.title = record['title']
        book.author_name = record['author_name']
        books << book
      end

      return books
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      sql = 'SELECT *  FROM books WHERE id = 1;'
      result = DatabaseConnection.exec_params(sql, [])

      book = Book.new

      book.id = result[0]['id']
      book.title = result[0]['title']
      book.author_name = result[0]['author_name']

      return book
  
    end
  
  
    # def create(student)
    # end
  
    # def update(student)
    # end
  
    # def delete(student)
    # end
  end