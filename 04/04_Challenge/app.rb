require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

recipe_repository.all.each do |record|
    p record.id
    p record.name
    p record.cooking_time
    p record.rating
end