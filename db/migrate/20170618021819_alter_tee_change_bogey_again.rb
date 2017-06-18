class AlterTeeChangeBogeyAgain < ActiveRecord::Migration[5.0]
  def change
    change_column :tees, :bogey_rating, :decimal, :precision => 4, :scale => 1
  end
end
