class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.string :photo
      t.integer :rating, unsigned: true, default: 0

      t.timestamps
    end
  end
end
