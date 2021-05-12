class ChangeTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :head_lines, :created_at, :datetime
    add_index :head_lines, :content_id, unique: true, name: 'unique_index_content_id'
  end
end
