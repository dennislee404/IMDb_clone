class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :name
      t.string :password_digest
      t.string :avatar, default: '/images/blank-profile-pic.png'
      t.timestamps
    end
  end
end
