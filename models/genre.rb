class Genre < ActiveRecord::Base
	has_and_belongs_to_many :movies
	
	validates_presence_of :genre
end