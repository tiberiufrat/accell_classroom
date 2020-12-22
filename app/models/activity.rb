class Activity < ApplicationRecord
  belongs_to :course, dependent: :destroy
  belongs_to :report, dependent: :destroy
end
