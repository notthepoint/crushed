class AddPostalCodeToCoins < ActiveRecord::Migration[6.0]
  def change
  	change_table :coins do |t|
			t.string :postal_code
		end
  end
end
