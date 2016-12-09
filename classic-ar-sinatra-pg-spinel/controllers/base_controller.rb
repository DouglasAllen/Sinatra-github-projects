not_found do
  erb :not_found, layout: :"layouts/main"
end

error 401 do
  erb :unauthorized, layout: :"layouts/main"
end

get '/' do
  @posts = Post.get_last(5)
  erb :"posts/index", layout: :"layouts/main"
end

get '/admin' do
  protected!
  @posts = Post.all
  erb :"admin/index", layout: :"layouts/main"
end
