get '/' do
  erb :'../app/views/index'
end

get '/home' do
  erb :'../app/views/auth/home'
end