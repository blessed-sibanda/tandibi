class CreateSights < ActiveRecord::Migration[6.1]
  def change
    create_table :sights do |t|
      t.bigint :place_id, null: false
      t.string :activity_type, null: false

      t.timestamps
    end

    add_foreign_key :sights, :places
  end
end
