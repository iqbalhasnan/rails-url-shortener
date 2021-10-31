class AddHypertable < ActiveRecord::Migration[6.1]
  def change
    remove_column :pageviews, :id, :bigint
    execute "SELECT create_hypertable('pageviews', 'created_at');"
  end
end