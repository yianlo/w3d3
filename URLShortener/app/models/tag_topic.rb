# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  tag_topic  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base
  validates :tag_topic, presence: true

  has_many :taggings,
    foreign_key: :tag_topic_id,
    primary_key: :id,
    class_name: 'Tagging'

  has_many :short_urls,
    -> { distinct },
    through: :taggings,
    source: :short_url

end
