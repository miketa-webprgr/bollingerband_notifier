class AddIndexToPrice < ActiveRecord::Migration[6.0]
  def change
    add_index :prices, :close
  end
end
