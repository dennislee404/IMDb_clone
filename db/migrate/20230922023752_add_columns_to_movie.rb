class AddColumnsToMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :runtime, :integer
    add_column :movies, :gross, :integer   
  end
end
