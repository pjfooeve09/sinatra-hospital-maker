class CreatePatientsTable < ActiveRecord::Migration[6.0]
  def change
   create_table :patients do |t|
     t.string :patient_name
     t.integer :age
     t.string :patient_place_of_birth
     t.integer :hospital_id
   end
  end
end