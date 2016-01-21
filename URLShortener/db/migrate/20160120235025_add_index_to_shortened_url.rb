class AddIndexToShortenedUrl < ActiveRecord::Migration
  def change
    remove_index :shortened_urls, :short_url
    add_index :shortened_urls, :short_url, unique: true

  end
end
