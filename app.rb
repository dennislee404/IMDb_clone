require 'sinatra'
require 'sinatra/activerecord'

require 'bcrypt'

require_relative 'models/movie'
require_relative 'models/review'
require_relative 'models/user'

enable :sessions