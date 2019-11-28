class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name, index: true
      t.string :author, index: true
      t.belongs_to :category, foreign_key: true
      t.integer :state, default: 0, null: false, index: true

      t.timestamps
    end
  end
end
