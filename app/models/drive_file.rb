class DriveFile < ApplicationRecord
  belongs_to :drive_fileable, dependent: :destroy, polymorphic: true
end
