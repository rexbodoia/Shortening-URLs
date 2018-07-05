class ShortenedUrl < ApplicationRecord
  validates :short_url, :user_id, presence: true
  
  def self.random_code 
    url = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: url)
      url = SecureRandom.urlsafe_base64(16)
    end
    url
  end
  
  def self.create(user_id, long_url)
    self.create!(long_url: long_url, short_url: self.random_code, user_id: user_id)
  end
  
  belongs_to :submitter,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
end