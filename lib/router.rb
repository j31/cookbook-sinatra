require_relative "controller"

class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def run
    puts "Welcome to the Cookbook!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.list
    when 2 then @controller.detail
    when 3 then @controller.edit
    when 4 then @controller.create
    when 5 then @controller.mark
    when 6 then @controller.destroy
    when 7 then @controller.import
    when 8 then stop
    else
      puts "Please choose a number"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all recipes"
    puts "2 - Show recipe detail"
    puts "3 - Edit recipe details"
    puts "4 - Create a new recipe"
    puts "5 - Mark/un-mark as tested"
    puts "6 - Delete a recipe"
    puts "7 - Import recipes from Let's Cook French"
    puts "8 - Stop and exit the program"
  end
end
