class Review < ActiveRecord::Base
	belongs_to :movie, required: true
	belongs_to :user, required: true

	validates_presence_of :user
	validates_presence_of :content
	
	validates :score, numericality: {
		only_integer: true,
		greater_than_or_equal_to: 1,
		less_than_or_equal_to: 10
	}

	after_create :update_movie_ratings
	after_create :update_review_count

	def update_movie_ratings
		ratings = movie.reviews.average(:score)
		movie.update_column(:ratings, ratings)
	end

	def update_review_count
		review_count = movie.review_count + 1
		review.update_column(:review_count, review_count)
	end
end