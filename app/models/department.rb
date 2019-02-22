class Department < ApplicationRecord
  has_many :groups
  has_many :subjects
  

  # validations
  validates :description, length: { maximum: 255 }
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
end
