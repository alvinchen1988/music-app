class Addusersandvotes < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true, index: true
      t.string :password_digest
      t.integer :num_votes
      t.timestamps null: false
    end

    create_table :votes do |t|
      t.references :user, index: true
      t.references :track, index: true
      t.timestamps null: false
    end
  end
end
