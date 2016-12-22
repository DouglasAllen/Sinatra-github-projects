helpers do 

  def authenticate(email, password)
     @user = User.find_by_email(email)
     if @user.password == password
      session[:user_id] = @user.id
    else
      redirect '/'
    end
  end 

  def create_user(name, email, password)
    @user = User.new(:name => name, :email => email)
    @user.password = password
    @user.save
    session[:user_id] = @user.id
  end

end