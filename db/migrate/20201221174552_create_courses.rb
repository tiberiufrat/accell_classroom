class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :classroom_id
      t.string :name
      t.string :section
      t.string :description
      t.datetime :creation_time
      t.string :enrollment_code
      t.string :course_state
      t.string :link
      t.references :user, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
