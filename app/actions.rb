# Homepage (Root path)

helpers do 

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

end

# before do 
#   @hello  = "IN CLASS"
# end

get '/' do
  erb :index
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    redirect '/tracks'
  else
    erb :'users/new'
  end
end

post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/tracks'
  else
    redirect '/?message=wrong password or username'
  end
end

delete '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/tracks/?' do
  @tracks = Track.all.order('num_votes DESC')
  erb :'tracks/index'
end

get '/tracks/new' do
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new
  @track.title = params[:title]
  @track.author = params[:author]
  @track.url = params[:url]
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

post '/cast-vote' do
  @vote = Vote.new
  @vote.user = current_user
  @vote.track_id = params[:track_id]
  if @vote.save
    redirect '/tracks?message=you have successfully voted a track'
  else
    redirect '/tracks?message=you already upvoted this track!'
  end
end 
