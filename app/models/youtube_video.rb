class YoutubeVideo < ApplicationRecord
  belongs_to :youtube_videoable, dependent: :destroy, polymorphic: true
end
