class CreateClientCompetitors < ActiveRecord::Migration
  def up
    create_table :client_competitors do |t|
    	t.references :store
    	t.references :store
      t.timestamps null: false
    end
  end

  def down
  	drop_table :client_competitors
  end
end
