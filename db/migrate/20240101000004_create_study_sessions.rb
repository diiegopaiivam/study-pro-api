class CreateStudySessions < ActiveRecord::Migration[7.1]
    def change
      create_table :study_sessions do |t|
        t.references :theme, null: false, foreign_key: true
        t.integer :correct, null: false, default: 0
        t.integer :wrong,   null: false, default: 0
        t.integer :total,   null: false, default: 0
        t.integer :percentage, null: false, default: 0
  
        t.timestamps
      end
    end
  end