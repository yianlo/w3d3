# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  short_url_id :integer          not null
#  tag_topic_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Tagging < ActiveRecord::Base
  validates :short_url_id, presence: true
  validates :tag_topic_id, presence: true

  belongs_to :tag_topic,
    foreign_key: :tag_topic_id,
    primary_key: :id,
    class_name: 'TagTopic'

  belongs_to :short_url,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: 'ShortenedUrl'
end
