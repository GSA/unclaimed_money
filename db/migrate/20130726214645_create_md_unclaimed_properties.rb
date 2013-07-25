class CreateMdUnclaimedProperties < ActiveRecord::Migration
  def change
    create_table :md_unclaimed_properties do |t|

      t.timestamps
    end
  end
end
