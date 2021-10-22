class CreatePageviews < ActiveRecord::Migration[6.1]
  def change
    create_table :pageviews do |t|
      t.references :short_link, index: true

      t.string :remote_ip
      t.string :geolocation
      t.timestamps
    end
  end
end
