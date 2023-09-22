require 'sinatra'
require 'sinatra/activerecord'

require 'csv'

class DataManager
	def self.load_movies(filename)

		CSV.foreach(filename, headers: true) do |row|
			movie = Movie.create(
				title: row[1],
				release_year: row[2],
				runtime: row[4],
				ratings: row[6],
				summary: row[7],
				director: row[9],
				gross: row[15],				
				)
		end
	end

	def self.update_movies(filename)

		CSV.foreach(filename, headers: true) do |row|
			movie.update(poster: row[1])
		end
	end
end

DataManager.load_movies('public/imdb_top_1000.csv')

movie.update(casts:)