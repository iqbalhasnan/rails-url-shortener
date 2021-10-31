class AddIndexing < ActiveRecord::Migration[6.1]
  def change
    add_index :links, :url
    add_index :short_links, :slug
  end
end
