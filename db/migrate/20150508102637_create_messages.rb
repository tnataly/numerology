class CreateMessages < ActiveRecord::Migration
	def change
		create_table :messages do |t|
			t.string :text
			t.integer :magic_number
		end
	end
end
