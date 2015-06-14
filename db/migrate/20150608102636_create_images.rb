class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :image
      t.integer :media_collection_id

      t.timestamps null: false
    end
  end
end
