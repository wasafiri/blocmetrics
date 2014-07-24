class App < ActiveRecord::Base

  validates :name, presence: true
  has_many :events
  belongs_to :user

end
