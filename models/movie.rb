class Book < ActiveRecord::Base
	has_many :reviews
	
	validates_presence_of :title
end