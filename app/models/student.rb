class Student < ApplicationRecord
  has_many :student_subjects
  has_many :subjects, through: :student_subjects
  belongs_to :group

  # validations
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }

  before_save :save_fullname

  def save_fullname
    self.name = self.lastname + " " + self.firstname
  end

  validate :validate_group

  def validate_group
    if group_id.blank?
      errors.add(:group_id, "Can't be blank")
    end

    group = Group.find_by_id(group_id)

    unless group
      errors.add(:group_id, "Not found with an id #{group_id}")
    end
  end
end
