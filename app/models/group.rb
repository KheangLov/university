class Group < ApplicationRecord
  has_many :students
  belongs_to :department

  # validations
  validates :description, length: { maximum: 255 }
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validate :validate_department

  def validate_department
    if department_id.blank?
      errors.add(:department_id, "Can't be blank")
    end

    department = Department.find_by_id(department_id)

    unless department
      errors.add(:department_id, "Not found with an id #{department_id}")
    end
  end
end