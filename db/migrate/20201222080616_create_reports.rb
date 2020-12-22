class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.datetime :date_start
      t.datetime :date_end
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
