class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.references :group, foreign_key: true, index: true

      t.string :lastname, null: false
      t.string :firstname, null: false
      t.string :name
      t.string :gender
      t.date :dob
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
