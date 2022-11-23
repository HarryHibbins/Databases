3. Define the class names

# Table name: books

# Model class
class Book
end

# Repository class
class BookRepository
end

4. Implement the modle class
# Table name: books

# Model class

class Book

  attr_accessor :id, :title, :author_name
end


5. Define the Repository Class interface

class BookRepository

  # Selecting all records
  # No arguments
  def all
    # SELECT * FROM books;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT *  FROM books WHERE id = $1;

    # Returns a single Student object.
  end


  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end

6. Write Test Examples


# 1
# Get all books

repo = BookRepository.new

books = repo.all

books.length # =>  2

books[0].id # =>  1
books[0].title # =>  'Book 1'
books[0].author_name # =>  'Author 1'

books[1].id # =>  2
books[1].title # =>  'Book 2'
books[1].author_name # =>  'Author 2'

# 2
# Get a single student

repo = BookRepository.new

book = repo.find(1)

book.id # =>  1
book.name # =>  'Book 1'
book.author_name # =>  'Author 1'



