class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name, unique: true, index: true
      t.string :description

      t.timestamps
    end
  end
end
