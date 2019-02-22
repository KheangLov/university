class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.references :department, foreign_key: true, index: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
