class AlterTeeChangeBogeyScale < ActiveRecord::Migration[5.0]
  def change
    change_column :tees, :bogey_rating, :decimal, :precision => 1, :scale => 1
  end
end
