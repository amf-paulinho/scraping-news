class ChangeTableRemoveField < ActiveRecord::Migration[6.1]
  def change
    remove_column :head_lines, :updated_at, :datetime
  end
end
