class CreateSportsTable < ActiveRecord::Migration[5.2]
    def change
        create_table :sports do |t|
            t.string :sport
            t.integer :age 
            t.text :skill_level
            t.integer :user_id
        end
    end
end