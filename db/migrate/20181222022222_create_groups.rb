class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.references :department, foreign_key: true, index: true

      t.string :name, null: false
      t.string :description
      
      t.timestamps
    end
  end
end
