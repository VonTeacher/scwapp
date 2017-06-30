class AlterRoundsAddIndexClubId < ActiveRecord::Migration[5.0]
  def change
    add_reference :rounds, :club, index: true
  end
end
