2. Create Test SQL seeds

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

- Below this line there should only be `INSERT` statements.
- Replace these statements with your own seed data.

INSERT INTO recipes (name, cooking_time, rating) VALUES ('Pizza', 20, 4);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Steak', 10, 5);


 - Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 recipes_directory_test < spec/seeds_{name}.sql

3. Define the class names 
Recipe

4. Modle class

class Recipe 
   attr_accessor :id, :name, :cooking_time, :rating
end
5. Define the Repository Class interface

RecipeRepository

- all
  # Executes the SQL query:
  * # SELECT * FROM recipes;

  # Returns all recipes

- find(id)
    # Executes the SQL query:
    * # SELECT * FROM recipes WHERE id = $1;

    # Returns a single recipe object.


6. Example tests 

* Get all recipes

repo = RecipeRepository.new
recipes = repo.all
recipes.length => 2

recipes[0].id => 1
recipes[0].name => Pizza
recipes[0].cooking_time => 20
recipes[0].rating => 4

recipes[1].id => 2
recipes[1].name => Steak
recipes[1].cooking_time => 10
recipes[1].rating => 5

* Get a single recipe

  repo = RecipeRepository.new
  recipe = repo.find(1)

  album.id => 1
  album.name => 'Pizza'
  album.cooking_time => 20
  album.rating => 4



7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # (your tests will go here).
end