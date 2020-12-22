class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.datetime :time
      t.references :course, null: false, foreign_key: true
      t.references :report, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
