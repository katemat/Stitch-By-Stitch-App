def logged_in? 
  if session[:user_id]  
    true
  else
    false
  end
end
  
  
def current_user
  find_one_user_by_id(session[:user_id])
end