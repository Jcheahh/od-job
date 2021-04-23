class Claim < ApplicationRecord
  belongs_to :user
  belongs_to :job

  enum status: [:created, :done]
end
