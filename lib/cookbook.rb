require 'csv'
require_relative "recipe"

class Cookbook
  # loads existing Recipe from the CSV
  def initialize(csv_file_path)
    @recipes = []
    @csv_path = csv_file_path
    @csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.foreach(@csv_path, @csv_options) do |line|
      if line[3] == "true"
        tested = true
      else
        tested = false
      end
      recipe = Recipe.new(line[0], line[1], line[2], tested, line[4])
      @recipes << recipe
    end
  end

  # returns all the recipies
  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  # adds a new recipe to the cookbook
  def add_recipe(recipe)
    @recipes << recipe
    # add to CSV file
    CSV.open(@csv_path, 'ab', @csv_options) do |csv|
      csv << [recipe.name, recipe.description, recipe.cooking_time, recipe.tested, recipe.difficulty]
    end
  end

  # updates CSV with current @recipies
  def update
    CSV.open(@csv_path, 'wb', @csv_options) do |csv|
      @recipes.each do |each|
        csv << [each.name, each.description, each.cooking_time, each.tested, each.difficulty]
      end
    end
  end

  # removes a recipe from the cookbook
  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
  end
end


