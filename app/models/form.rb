class Form < ApplicationRecord
  belongs_to :formable, dependent: :destroy, polymorphic: true
end
