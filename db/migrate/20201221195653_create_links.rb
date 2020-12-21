class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :url
      t.string :titile
      t.string :thumbnail
      t.references :linkable, polymorphic: true

      t.timestamps
    end
  end
end
