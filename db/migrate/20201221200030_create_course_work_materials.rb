class CreateCourseWorkMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :course_work_materials do |t|
      t.string :classroom_id
      t.string :title
      t.string :description
      t.integer :materials
      t.datetime :creation_time
      t.boolean :all_students
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
