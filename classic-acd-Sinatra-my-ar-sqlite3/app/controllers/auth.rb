get '/auth/home' do
  if current_user
    redirect '/home'
  else
    erb :welcome
  end
end

get '/login' do
  erb :'../app/views/auth/login'
end

post '/login' do
  p params.each
  @user = User.find_by(name: 'Douglas') #params[:user][:name]).try(:authenticate, params[:user][:password])
  
  if @user
    p session[:uid] = @user.id    
    redirect '/'
  else
    set_error!("The username or password is incorrect.")
    p session[:uid] = @user.id  
    redirect '/login'
  end
end

get '/signup' do
  erb :'../app/views/auth/signup'
end

post '/signup' do
  user = User.create(params[:user])

  if user.save
    session[:uid] = user.id
    user.avatar_url = "#{Faker::Avatar.image}"
    redirect '/'
  else
    set_error!("Sorry, looks like something went wrong. The new user was not saved. Please try again.")
    redirect '/signup'
  end
end

get '/logout' do
  session[:uid] = nil  
  redirect '/'
end

get '/sign_out' do
  session[:uid] = nil
  redirect '/'
end