# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  premium_user :boolean          default("false")
#

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true


  has_many :submitted_urls,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: 'ShortenedUrl'

  has_many :visits,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Visit'

  has_many :visited_urls,
    -> { distinct },
    through: :visits,
    source: :short_url

end
