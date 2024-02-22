class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.boolean :winner, default: false
      t.bigint :distance

      t.timestamps
    end
  end
end
