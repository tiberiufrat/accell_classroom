class CreateForms < ActiveRecord::Migration[6.1]
  def change
    create_table :forms do |t|
      t.string :url
      t.string :response_url
      t.string :title
      t.string :thumbnail
      t.references :formable, polymorphic: true

      t.timestamps
    end
  end
end
