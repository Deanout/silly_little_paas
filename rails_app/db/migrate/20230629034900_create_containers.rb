class CreateContainers < ActiveRecord::Migration[7.0]
  def change
    create_table :containers do |t|
      t.string :name
      t.integer :port
      t.string :container_name

      t.timestamps
    end
  end
end
