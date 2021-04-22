class Job < ApplicationRecord
  belongs_to :user
  has_one :claim

  validates_presence_of :title
end
