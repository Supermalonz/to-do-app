class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.boolean :status
      t.references :user

      t.timestamps
    end
  end
end
