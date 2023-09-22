class AddPosterToMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :poster, :string
    add_column :casts, :photo, :string   
  end
end
