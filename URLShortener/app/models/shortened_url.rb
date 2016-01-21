# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  short_url    :string           not null
#  long_url     :string           not null
#  submitter_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, length: { maximum: 1024 }
  validates :submitter_id, presence: true, if: :less_than_five_recents? && :less_than_five?

  belongs_to :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: 'User'

  has_many :visits,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: 'Visit'

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: 'Tagging'

  has_many :tag_topics,
    -> { distinct },
    through: :taggings,
    source: :tag_topic


  def self.random_code
    code = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      'short_url' => ShortenedUrl.random_code,
      'long_url' => long_url,
      'submitter_id' => user.id
      )
  end



  def less_than_five_recents?
    submissions = self.class.where(submitter_id: submitter_id).order(created_at: :desc).limit(5)
    # return true if submissions.count < 5

    raise "Too many submissions within the last minute" unless submissions.last.created_at > 1.minute.ago
  end


  def less_than_five?
    return true if self.submitter.premium_user

    submissions = self.class.where(submitter_id: submitter_id)
      raise "Too many submissions - buy our premium product" unless submissions.length < 3
  end

  def num_clicks
    # self.visitors.size
    self.visits.count
  end

  def num_uniques
    # self.visitors.uniq.size
    # self.visits.select(:user_id).distinct.count
    self.visitors.count
  end

  def num_recent_uniques
    # #did not work
    # self.visits.where("created_at = ?", created_at).distinct.count(:user_id)
    # self.visits.where(created_at: created_at).distinct.count(:user_id)
    #
    # # #worked!
    # self.visits.where("created_at >= ?", created_at).distinct.count(:user_id)
    self.visits.where(created_at: 10.minutes.ago..Time.zone.now).distinct.count(:user_id)

  end

end
