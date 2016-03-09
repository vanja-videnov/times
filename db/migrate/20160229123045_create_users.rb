class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :phone
      t.boolean :admin, default: false
      t.string :salt
      t.timestamps null: false
    end
  end
end
