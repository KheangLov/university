class CreateStudentSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :student_subjects do |t|
      t.references :department, foreign_key: true, index: true
      t.references :subject, foreign_key: true, index: true
      t.references :student, foreign_key: true, index: true
      t.decimal :score, precision: 10, scale: 2
      t.decimal :homework, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
