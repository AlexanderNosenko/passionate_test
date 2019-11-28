class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, index: true
      t.belongs_to :vertical, foreign_key: true
      t.integer :state, default: 0, null: false, index: true

      t.timestamps
    end
  end
end
