class AddReviewCountToMovies < ActiveRecord::Migration[7.0]
  def change
      add_column :movies, :review_count, :integer, default: 100
  end
end
