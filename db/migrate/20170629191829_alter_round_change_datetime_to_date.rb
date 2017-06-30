class AlterRoundChangeDatetimeToDate < ActiveRecord::Migration[5.0]
  def change
    change_column :rounds, :date_played, :date
  end
end
