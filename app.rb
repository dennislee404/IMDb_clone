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

CarrierWave.configure do |config|
	config.root = './public'
end

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
	if user_signed_in?
		redirect '/'
	else 
		erb :login , :layout => :layout2
	end	
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
	if user_signed_in?
		erb :register, :layout => :layout2
	else
		redirect '/login'
	end		
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
	if user_signed_in?
		@reviews = Review.where(user_id: current_user.id)
		erb :profile
	else
		redirect '/login'
	end
end

get '/update-profile' do 
	if user_signed_in?
		erb :update_profile
	else
		redirect '/login'
	end
end

post '/update-profile' do 
	current_user.update(avatar: params[:avatar], username: params[:username])

	redirect '/profile'
end

get '/movies/:id' do 
	@movie = Movie.find(params[:id])
	erb :movie2
end

get '/review/:id' do 
	if user_signed_in?
		@movie = Movie.find(params[:id])
		@reviews = Review.where(movie_id: params[:id])

		erb :review
	else
		redirect '/login'
	end
end

post '/review/:id' do 
	@movie = Movie.find(params[:id])
	@review = current_user.reviews.create(score: params[:score], content: params[:review_content], movie_id: params[:id])
	@reviews = Review.where(movie_id: params[:id])

	if @review.save
		redirect "/movies/#{@movie.id}"
	else
		erb :review
	end
end

