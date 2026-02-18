class CreateSubjects < ActiveRecord::Migration[7.1]
    def change
      create_table :subjects do |t|
        t.references :users, null: false, foreign_key: true
        t.string :name, null: false
        t.string :color
  
        t.timestamps
      end
    end
end