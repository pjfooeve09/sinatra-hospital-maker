class CreateHospitalsTable < ActiveRecord::Migration[6.0]
    def change
      create_table :hospitals do |t|
       t.string :hospital_name
       t.string :hospital_country
       t.integer :user_id
      end
    end
  end