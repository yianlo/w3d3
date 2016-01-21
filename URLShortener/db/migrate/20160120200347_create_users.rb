class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text 'email', null: false
      t.timestamps null: false
    end

    add_index 'users', 'email'
  end
end
