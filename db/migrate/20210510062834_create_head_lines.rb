class CreateHeadLines < ActiveRecord::Migration[6.1]
  def change
    create_table :head_lines do |t|
      t.string :source, null: false
      t.string :content_id, null: false
      t.string :title, null: false
      t.string :excerpt
      t.string :link, null: false
      t.string :image
      t.datetime :publish_date
      t.datetime :update_date
      t.datetime :scrape_date, null: false

      t.timestamps
    end
  end
end
