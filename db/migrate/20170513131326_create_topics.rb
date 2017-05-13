class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.text    :body, null: false
      t.timestamps
    end
  end
end
