require 'nokogiri'
require 'open-uri'
require_relative "view"
require_relative "recipe"
require_relative "scraper_service"

class Controller
  #  takes an instance of the Cookbook as an argument.
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # list all the recipes
  def list
    # recipes = @cookbook.all
    # @view.list(recipes) if recipes.length > 0
    @cookbook.all
  end

  # show recipe detail
  def detail
    # recipes = @cookbook.all
    # @view.list(recipes)
    recipe_index = 0
    recipe = @cookbook.find(recipe_index)
    # @view.show_detail(recipe)
  end

  # edit recipe detail
  def edit
    # select recipe
    recipes = @cookbook.all
    @view.list(recipes)
    recipe_index = @view.pick
    recipe = @cookbook.find(recipe_index)

    #select what to edit
    detail_number = @view.pick_detail(recipe)

    # udpate recipe
    if detail_number == 2
      recipe.toggle_tested
    else
      new_value = @view.edit_detail
      if detail_number == 1
        recipe.update_name(new_value)
      elsif detail_number == 3
        recipe.update_cooking_time(new_value)
      elsif detail_number == 4
        recipe.update_difficulty(new_value)
      elsif detail_number == 5
        recipe.update_description(new_value)
      end
    end
    @cookbook.update
  end

  # create a new recipe
  def create
    recipe = Recipe.new(@view.ask_name, @view.ask_desc, @view.ask_time)
    @cookbook.add_recipe(recipe)
  end

   # toggle recipe tested/untested
  def mark
    recipes = @cookbook.all
    @view.list(recipes)
    recipe_index = @view.pick
    @recipe = @cookbook.find(recipe_index)
    @recipe.toggle_tested
    @cookbook.update
  end

  def import
    ingredient = @view.ask_ingredient
    scraped_recipies = ScraperService.new.scraper(ingredient)

    # choose level
    levels = []
    scraped_recipies.each { |d| levels << d.difficulty }
    levels = levels.uniq
    level = @view.choose_level(levels).to_i
    if level == 0
      import_these = scraped_recipies
    else
      diff = levels[level - 1]
      import_these = scraped_recipies.select { |d| d.difficulty == diff }
    end

    # pick recipe to import
    recipe_index = @view.pick_import(import_these, diff)
    recipe = import_these[recipe_index]

    #add to cookbook
    @cookbook.add_recipe(recipe)
  end

  # destroy an existing recipe
  def destroy
    recipes = @cookbook.all
    @view.list(recipes)
    recipe_index = @view.pick
    @cookbook.remove_recipe(recipe_index)
    @cookbook.update
  end
end


