class CreateCaUnclaimedProperties < ActiveRecord::Migration
  def change
    create_table :ca_unclaimed_properties do |t|

      t.timestamps
    end
  end
end
