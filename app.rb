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

get '/' do
	@highest_rating_movies = Movie.order(ratings: :desc).take(6)
	@newest_movies = Movie.order(release_year: :desc).take(6)
	@nolan_movies = Movie.where(director: "Christopher Nolan").order(ratings: :desc).take(6)

	erb :index
end

def current_user
	@current_user ||= User.find_by(id: session[:user_id])
end

get '/login' do
	erb :login
end

post '/login' do 
	@user = User.find_by(username: params[:username])

	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect '/'
	else
		redirect '/login'	
	end
end

post '/logout' do 
	session[:user_id] = nil
	redirect '/login'
end

get '/register' do 
	erb :register
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

get '/movies/:id' do 
	erb :movie
end

