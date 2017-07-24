require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "csv"
require_relative "lib/controller"
require_relative "lib/cookbook"
require_relative "lib/recipe"

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @csv_file = File.join(__dir__, 'lib/recipes.csv')
  @cookbook = Cookbook.new(@csv_file)
  @controller = Controller.new(@cookbook)
  erb :index
end

get '/detail.erb' do
  @csv_file = File.join(__dir__, 'lib/recipes.csv')
  @cookbook = Cookbook.new(@csv_file)
  @controller = Controller.new(@cookbook)
  erb :detail
end


post '/runMethod' do
    erb :detail
end

# get '/about' do
#   erb :about
# end

# get '/team/:username' do
#   puts params[:username]
#   "The username is #{params[:username]}"
# end


