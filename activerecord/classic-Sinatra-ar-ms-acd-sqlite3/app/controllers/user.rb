get '/users' do
  @users = User.all
  erb :'../app/views/users/index'
end

get '/users/:username' do
  p @user = User.find(params[:uid])
  erb :'../app/views/users/index'
end
