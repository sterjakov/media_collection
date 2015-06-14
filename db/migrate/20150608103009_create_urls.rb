class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :name
      t.string :url
      t.integer :media_collection_id

      t.timestamps null: false
    end
  end
end
