class Movie < ActiveRecord::Base
	has_many :reviews
	has_and_belongs_to_many :casts
	has_and_belongs_to_many :genres
	
	validates_presence_of :title
end