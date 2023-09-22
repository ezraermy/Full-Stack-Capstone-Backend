class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.text :description
      t.string :location
      t.decimal :daily_rate
      t.string :car_type
      t.string :image

      t.timestamps
    end
  end
end
