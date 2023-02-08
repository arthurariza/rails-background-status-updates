class CreateImports < ActiveRecord::Migration[7.0]
  def change
    create_table :imports do |t|
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
