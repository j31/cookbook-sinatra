require_relative "recipe"

class View
  def ask_name
    puts "Recipe name:"
    gets.chomp
  end

  def ask_desc
    puts "Recipe description:"
    gets.chomp
  end

  def ask_time
    puts "Recipe preparation time in minutes:"
    gets.chomp + " min"
  end

  def choose_level(levels)
    puts "0 - All levels"
    levels.each_with_index { |level, i| puts "#{i + 1} - #{level}"}
    puts "What difficulty levels would you like to import?"
    gets.chomp
  end


  def list(recipes)
    puts " Tested?    Recipe                                     Time     Difficulty"
    puts "--------------------------------------------------------------------------"
    recipes.each_with_index do |recipe, i|
      print "#{i + 1}"
      print " " if (i + 1) < 10
      print " - #{recipe.tested?}    #{recipe.name}"
      (43 - recipe.name.length).times { print " " }
      puts "#{recipe.cooking_time}   #{recipe.difficulty}"
    end
  end

  def pick
    puts "Which recipe?"
    gets.chomp.to_i - 1
  end

  def show_detail(recipe)
    puts ""
    puts "Name         #{recipe.name}"
    puts "Tested?      #{recipe.tested?}"
    puts "Prep time    #{recipe.cooking_time}"
    puts "Difficulty   #{recipe.difficulty}"
    puts "Description: #{recipe.description}"
    puts ""
  end

  def pick_detail(recipe)
    puts ""
    puts "1.  Name         #{recipe.name}"
    puts "2.  Tested?      #{recipe.tested?}"
    puts "3.  Prep time    #{recipe.cooking_time}"
    puts "4.  Difficulty   #{recipe.difficulty}"
    puts "5.  Description: #{recipe.description}"
    puts ""
    puts "Which detail (1-5)?"
    gets.chomp.to_i
  end

  def edit_detail
    puts "Change to: "
    new_value = gets.chomp
  end

  def ask_ingredient
    puts "What ingredient would you like a recipe for?"
    ingredient = gets.chomp
    puts "Looking for \'#{ingredient}\' on LetsCookFrench..."
    return ingredient
  end

  def pick_import(results, diff)
    puts "Here are the #{diff} recipes:"
    results.each_with_index { |recipe, i| puts "#{i + 1} - #{recipe.name}" }
    puts ""
    puts "Which recipe number would you like to import?"
    gets.chomp.to_i - 1
  end
end
