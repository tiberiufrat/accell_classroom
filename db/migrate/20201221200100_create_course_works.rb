class CreateCourseWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :course_works do |t|
      t.string :classroom_id
      t.string :title
      t.string :description
      t.integer :materials
      t.datetime :creation_time
      t.datetime :due_date
      t.string :work_type
      t.boolean :all_students
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
