class AddClassroomIdAndProfilePictureToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :classroom_id, :string
    add_column :users, :image, :string
  end
end
