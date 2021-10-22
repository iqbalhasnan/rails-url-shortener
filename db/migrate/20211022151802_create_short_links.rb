class CreateShortLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :short_links do |t|
      t.references :link, index: true
      t.string :slug
      t.timestamps
    end
  end
end
