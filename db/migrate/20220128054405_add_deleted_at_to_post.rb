class AddDeletedAtToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :deleted_at, :timestamp
  end
end
