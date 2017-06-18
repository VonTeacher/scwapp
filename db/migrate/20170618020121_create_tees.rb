class CreateTees < ActiveRecord::Migration[5.0]
  def change
    create_table :tees do |t|
      t.string :color
      t.decimal :usga_course_rating_18
      t.integer :slope_rating_18
      t.decimal :front_9_rating
      t.integer :front_9_slope
      t.decimal :back_9_rating
      t.integer :back_9_slope
      t.decimal :bogey_rating
      t.string :gender
      t.references :club

      t.timestamps
    end
  end
end
