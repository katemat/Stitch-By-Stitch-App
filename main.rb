# dependencies
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg' 
require 'cloudinary'

require_relative 'models/project'
require_relative 'models/user'
require_relative 'models/image'
require_relative 'models/like'
require_relative 'lib'

enable :sessions

auth = {
  cloud_name: "dojrv9v91",
  api_key: ENV['API_KEY'], 
  api_secret: ENV['API_SECRET']
}

get '/' do
  projects = all_projects()
  likes_count = find_likes_count_by_project_id(params[:id])

  erb(:index, locals: {
    projects: projects,
    likes_count: likes_count
  })
end

get '/projects' do
  projects = all_projects()

  erb(:index, locals: {
    projects: projects
  })
end


get '/projects/new' do
  # redirect "/login" unless logged_in?
  erb(:'/projects/new')
end


get '/projects/:id' do 
  project = find_one_project_by_id(params[:id])
  user = find_one_user_by_id(project["user_id"])
  likes_count = find_likes_count_by_project_id(params[:id])
  
  # images = all_images_by_project_id(params[:id])
  
  erb(:'projects/show', locals: {
    project: project,
    user: user,
    likes_count: likes_count
    # images: images
  })
end

post '/projects' do
  # # guard condition
  # redirect "/login" unless logged_in?
  auth = {
    cloud_name: "dojrv9v91",
    api_key: ENV['API_KEY'], 
    api_secret: ENV['API_SECRET']
  }

  image = Cloudinary::Uploader.upload(params[:image][:tempfile], auth)
  

  create_project(params[:title], params[:design],params[:size],params[:colors],params[:fabric_count],params[:start],params[:finish],params[:details],image['secure_url'],current_user['id'])
  redirect "/"
end

delete '/projects' do
  # redirect "/login" unless logged_in?
  delete_project(params[:id])
  redirect "/"
end

get '/projects/:id/edit' do
  # redirect "/login" unless logged_in?
  project = find_one_project_by_id(params[:id])
  
  erb(:'/projects/edit', locals: { project: project })
end

patch '/projects' do
  # redirect "/login" unless logged_in?
  auth = {
    cloud_name: "dojrv9v91",
    api_key: ENV['API_KEY'], 
    api_secret: ENV['API_SECRET']
  }

  image = Cloudinary::Uploader.upload(params[:image][:tempfile], auth)

  update_project(
    params[:id], 
    params[:title], 
    params[:design],
    params[:size],
    params[:colors],
    params[:fabric_count],
    params[:start],
    params[:finish],
    params[:details],
    image['secure_url']
  )
  redirect "/projects/#{params[:id]}"  
end

get '/login' do
  erb(:'/sessions/login')
end

post '/login' do
  user = find_one_user_by_email(params[:email] )

  if user && BCrypt::Password.new(user["password_digest"]) == params[:password]
    session[:user_id] = user['id'] 
    redirect "/"
  else
    erb :'/sessions/login'
  end
end

get '/signup' do 
  erb(:'/user/new')
end

post '/signup' do
  user = create_user(params[:name], params[:email], params[:password])
  redirect "/login"
end

delete '/logout' do
  session[:user_id] = nil
  redirect "/"
end

get '/designs' do
  projects = all_designs()
  erb(:'/designs/index', locals: {
    projects: projects
  })
end

get '/designs/:design' do
  design = params[:design]
  projects = find_projects_by_design(params[:design])

  erb(:'/designs/show', locals: {
    projects: projects, design: design
  })
end

get '/projects/user/:user_id' do

  user_projects = find_all_projects_by_user_id(params[:user_id])

  erb(:'user/index', locals: {
    user_projects: user_projects,
  
  })
end

post '/likes' do
 
  create_or_delete_like(params[:project_id], session[:user_id])
  redirect "/projects/#{params[:project_id]}"
end


