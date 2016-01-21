# == Schema Information
#
# Table name: visits
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  short_url_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Visit < ActiveRecord::Base

  belongs_to :short_url,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: 'ShortenedUrl'

  belongs_to :visitor,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'

  def self.record_visit!(user, shortened_url)
    self.create!('user_id' => user.id, 'short_url_id' => shortened_url.id)
  end

end
