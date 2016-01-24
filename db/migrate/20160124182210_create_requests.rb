class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :keywords

      t.timestamps null: false
    end
  end
end
