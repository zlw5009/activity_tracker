require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"
require 'pry'

require_relative "database"

configure(:development) do
  require "sinatra/reloader"
  also_reload "sequel_persistence.rb"
end

before do 
  @storage = Database.new
end

helpers do
  def load_subjects
    @storage.all_subjects
  end

  def new_subject(subject_name)
    @storage.create_new_subject(subject_name)
  end

  def delete_subject(subject_id)
    @storage.delete_subject(subject_id)
  end

  def load_topics(subject_id)
    topics = @storage.all_topics(subject_id)

    if (topics.empty?)
      topics = @storage.subject_name(subject_id)
    end

    topics
  end

  def new_topic(topic_name, subject_id)
    @storage.create_new_topic(topic_name, subject_id)
  end

  def delete_topic(topic_id)
    @storage.delete_topic(topic_id)
  end
end

get '/' do
  @subjects = load_subjects

  erb :index
end

post '/' do
  subject_name = params[:new_subject].strip

  new_subject(subject_name)
  redirect '/'
end

get '/edit' do
  @subjects = load_subjects

  erb :edit_index
end

post '/subject/:id/destroy' do
  subject_id = params[:id].to_i

  delete_subject(subject_id)
  redirect '/'
end

get '/subject/:id' do
  @subject_id = params[:id].to_i
  @all_topics = load_topics(@subject_id)

  erb :topics
end

post '/subject/:id' do
  topic_name = params[:new_topic].strip
  subject_id = params[:id].to_i

  new_topic(topic_name, subject_id)

  redirect "/subject/#{subject_id}"
end

get '/subject/:id/edit' do 
  @subject_id = params[:id].to_i
  @all_topics = load_topics(@subject_id)

  erb :edit_topics
end

post '/subject/:subject_id/topic/:id/destroy' do
  topic_id = params[:id]
  subject_id = params[:subject_id]

  delete_topic(topic_id)

  redirect "/subject/#{subject_id}"
end