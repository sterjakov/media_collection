class CreateMediaCollections < ActiveRecord::Migration
  def change
    create_table :media_collections do |t|
      t.integer :user_id
      t.string :name
      t.integer :available

      t.timestamps null: false
    end
  end
end
