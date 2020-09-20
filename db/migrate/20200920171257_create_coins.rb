class CreateCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :coins do |t|
      t.string :title
			t.string :description
			t.string :address
			t.string :city
			t.string :country

			t.st_point :longlat, geographic: true

      t.timestamps
    end
    add_index :coins, :longlat, using: :gist
  end
end
