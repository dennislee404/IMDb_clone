class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.text :summary
      t.integer :release_year
      t.float :ratings
      t.string :genre
      t.string :cast
      t.timestamps
    end
  end
end
