class CreateTaggingsTable < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :short_url_id, null: false
      t.integer :tag_topic_id, null: false

      t.timestamps
    end

    create_table :tag_topics do |t|
      t.string :tag_topic, unique: true, null: false

      t.timestamps
    end

  end
end
