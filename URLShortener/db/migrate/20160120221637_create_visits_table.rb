class CreateVisitsTable < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :short_url_id, null: false

      t.timestamps
    end
  end
end
