class CreateDriveFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :drive_files do |t|
      t.string :classroom_id
      t.string :title
      t.string :link
      t.string :thumbnail
      t.references :drive_fileable, polymorphic: true

      t.timestamps
    end
  end
end
