get '/posts' do
  @posts = Post.published
  erb :"posts/index", layout: :"layouts/main"
end

post '/posts' do
  protected!
  post_params = params[:post].merge!(created_at: Time.now.to_s)
  @post = Post.new(post_params)
  if @post.save
    redirect '/'
  else
    redirect '/posts/new'
  end
end

get '/posts/new' do
  protected!
  @post = Post.new
  erb :"posts/new", layout: :"layouts/main"
end

get "/posts/:id" do
  begin
    @post = Post.find(params[:id])
    @posts = Post.published
    erb :"posts/show", layout: :"layouts/main"
  rescue ActiveRecord::RecordNotFound => e
    status 404
    erb :not_found, layout: :"layouts/main"
  end
end

get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  erb :"posts/edit", layout: :"layouts/main"
end

put "/posts/:id" do
  protected!
  post = Post.find(params[:id])
  if post.update_attributes(params[:post])
    redirect '/'
  else
    erb :"posts/edit", layout: :"layouts/main"
  end
end

delete "/posts/:id" do
  protected!
  post = Post.find(params[:id]).destroy
end
