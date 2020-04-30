# dependencies
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg' 


require_relative 'models/project'
require_relative 'models/user'
require_relative 'models/image'
require_relative 'lib'

enable :sessions


get '/' do
  projects = all_projects()

  erb(:index, locals: {
    projects: projects
  })
end


get '/projects/new' do
  redirect "/login" unless logged_in?
  erb(:'/projects/new')
end


get '/projects/:id' do 
  project = find_one_project_by_id(params[:id])
  user = find_one_user_by_id(project["user_id"])
  # images = all_images_by_project_id(params[:id])
  
  erb(:'projects/show', locals: {
    project: project,
    user: user
    # images: images
  })
end

post '/projects' do
  # guard condition
  redirect "/login" unless logged_in?
  create_project(params[:title], params[:design],params[:size],params[:colors],params[:fabric_count],params[:start],params[:finish],params[:details],params[:main_image_url],current_user['id'])
  redirect "/"
end

delete '/projects' do
  redirect "/login" unless logged_in?
  delete_project(params[:id])
  redirect "/"
end

get '/projects/:id/edit' do
  redirect "/login" unless logged_in?
  project = find_one_project_by_id(params[:id])
  
  erb(:'/projects/edit', locals: { project: project })
end

patch '/projects' do
  redirect "/login" unless logged_in?
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
    params[:main_image_url],
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





