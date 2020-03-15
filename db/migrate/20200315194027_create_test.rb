class CreateTest < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :color
    end
  end
end
