class CreateGroupMatchExculsions < ActiveRecord::Migration
  def up
    create_table :group_match_exculsions do |t|
    	t.references :group
    	t.references :match_exclusion
      t.timestamps null: false
    end
  end

  def down
  	drop_table :group_match_exculsions
  end
end
