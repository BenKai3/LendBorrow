class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.integer :money
      t.string :purpose
      t.text :description
      t.integer :raised
      t.date :created_at
      t.date :updated_at

      t.timestamps null: false
    end
  end
end
