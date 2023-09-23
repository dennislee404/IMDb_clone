require 'sinatra'
require 'sinatra/activerecord'

require 'bcrypt'

require 'carrierwave'
require 'carrierwave/orm/activerecord'

require_relative 'models/photouploader'

require_relative 'models/movie'
require_relative 'models/review'
require_relative 'models/user'
require_relative 'models/cast'
require_relative 'models/genre'

enable :sessions

def current_user
	@current_user ||= User.find_by(id: session[:user_id])
end

def user_signed_in?
	current_user != nil
end

get '/' do
	@highest_rating_movies = Movie.order(ratings: :desc).take(6)
	@newest_movies = Movie.order(release_year: :desc).take(6)
	@nolan_movies = Movie.where(director: "Christopher Nolan").order(ratings: :desc).take(6)

	erb :index
end

get '/login' do
	erb :login , :layout => :layout2
end

post '/login' do 
	@user = User.find_by(email: params[:email])

	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect '/'
	else
		redirect '/login'	
	end
end

get '/logout' do 
	session[:user_id] = nil
	redirect '/'
end

get '/register' do 
	erb :register, :layout => :layout2
end

post '/register' do 
	@user = User.create(
		email: params[:email],
		username: params[:username],
		password: params[:password],
		password_confirmation: params[:password_confirmation]
		)

	if @user.save
		redirect '/login'
	else
		redirect '/register'
	end
end

get '/profile' do 
	erb :profile
end

get '/movies/:id' do 
	@movie = Movie.find(params[:id])
	erb :movie2
end

get '/review/:id' do 
	if user_signed_in?
		@movie = Movie.find(params[:id])

		erb :review, :layout => :layout2
	else
		redirect '/login'
	end
end

post '/review/:id' do 
	@movie = Movie.find(params[:id])

	erb :movie2
end

