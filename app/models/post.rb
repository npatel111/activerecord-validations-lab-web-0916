class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: { in: %w(Fiction Non-Fiction),
    message: "%{value} is not a valid category" }
  validate :clickbait?
end

def clickbait?
  clickbait_stuff = [/Won't Believe/, /Secret/, /Top [0-9]/, /Guess/]
  if clickbait_stuff.none? { |phrase| phrase.match(title) }
    errors.add(:title, "must be clickbait")
  end
end
