class CreateYoutubeVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :youtube_videos do |t|
      t.string :classroom_id
      t.string :title
      t.string :link
      t.string :thumbnail
      t.references :youtube_videoable, polymorphic: true

      t.timestamps
    end
  end
end
