require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require 'pry'

require_relative "database"

before do 
  @storage = Database.new
end

get '/' do
  @subjects = @storage.all_subjects
  erb :index
end

post '/' do
  subject_name = params[:subject_name].strip

  @storage.create_new_subject(subject_name)
  redirect '/'
end