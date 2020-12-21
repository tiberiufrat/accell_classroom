class Link < ApplicationRecord
  belongs_to :linkable, dependent: :destroy, polymorphic: true
end
