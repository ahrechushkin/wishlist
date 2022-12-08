class WishlistApp < Sinatra::Base
  set :sessions => true

  get '/' do
    redirect '/users'
  end

  get '/wishlists/new' do
    authenticate_user!
    erb :"wishlists/new"
  end

  post '/wishlists' do
    authenticate_user!
    wishlist = Wishlist.new(params[:wishlist])
    wishlist.user = current_user
    if wishlist.save
      redirect "/wishlists/#{wishlist.id}"  
    end
    rescue ActiveRecord::RecordInvalid
      redirect "/wishlists/new"
  end

  get '/wishlists/:id' do
    authenticate_user!
    @wishlist = Wishlist.find(params[:id])
    erb :"wishlists/show"
  end

  get '/wishlists/:id/items/new' do
    authenticate_user!
    @wishlist = Wishlist.find(params[:id])
    erb :"wishlist_items/new"
  end

  post '/wishlists/:id/items' do
    authenticate_user!
    wishlist = Wishlist.find(params[:id])
    wishlist_item = wishlist.wishlist_items.create!(params[:wishlist_item])
    redirect "/wishlists/#{wishlist.id}"
  end


  get '/signup' do
    erb :"users/new"
  end

  post '/signup' do
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect '/users'
    else
      erb :"users/new"
    end
  end

  get '/users' do
    authenticate_user!
    @users = User.all
    erb :"users/index"
  end

  get '/users/:id' do
    authenticate_user!
    @user = User.find(params[:id])
    @wishlists = @user.wishlists
    erb :"wishlists/index"
  end

  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect '/login'
    end
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user!
    redirect '/login' unless logged_in?
  end

end