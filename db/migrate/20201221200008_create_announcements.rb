class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements do |t|
      t.string :classroom_id
      t.string :text
      t.integer :materials
      t.datetime :creation_time
      t.boolean :all_students
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
