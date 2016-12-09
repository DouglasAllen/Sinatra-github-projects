
def current_user
  if session[:uid]
    user = User.find(session[:uid])
  else 
    user = User.first
  end
end

def signed_in?
  !current_user.nil?
end

def set_error!(error_msg)
  session[:error] = error_msg
end

def display_error!
  error = session[:error]
  session[:error] = nil
  error
end

def find_user_by_id(uid)
  sql = 'SELECT * FROM users WHERE uid = $1 LIMIT 1'
  @user = db_connection do |db|
    db.exec_params(sql, [uid])
  end
  @user = User.find(params[:uid])
  #@user = User.first
end