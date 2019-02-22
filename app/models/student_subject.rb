class StudentSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :department
  belongs_to :student

  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 , less_than_or_equal_to: 60 }
  validates :homework, presence: true, numericality: { greater_than_or_equal_to: 0 , less_than_or_equal_to: 40 }
  validate :validate_all_relations
  before_save :calculate_total

  def calculate_total
    self.total = self.score + self.homework
  end

  def validate_all_relations
    if department_id.blank?
      errors.add(:department_id, "Can't be blank")
    else
      department = Department.find_by_id(department_id)

      unless department
        errors.add(:department_id, "Not found with an id #{department_id}")
      end
    end

    if student_id.blank?
      errors.add(:student_id, "Can't be blank")
    else
      student = Student.find_by_id(student_id)

      unless student
        errors.add(:student_id, "Not found with an id #{student_id}")
      end
    end

    if subject_id.blank?
      errors.add(:subject_id, "Can't be blank")
    else
      subject = Subject.find_by_id(subject_id)

      unless subject
        errors.add(:subject_id, "Not found with an id #{subject_id}")
      end
    end

    if subject_id && student_id && department_id
      student_subject = StudentSubject.find_by(subject_id: subject_id, student_id: student_id, department_id: department_id)

      if student_subject
        errors.add(:subject, "already have")
      end
    end
  end
end
