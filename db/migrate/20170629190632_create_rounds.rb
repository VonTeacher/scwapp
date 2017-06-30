class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.integer :adjusted_score
      t.datetime :date_played
      t.references :user, foreign_key: true
      t.references :tee, foreign_key: true

      t.timestamps
    end
  end
end
