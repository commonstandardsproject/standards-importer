class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :jurisdictions do |t|
      t.column :csp_id, :string
      t.column :document, :json
      t.string :title
      t.string :type
    end

    add_index :jurisdictions, :csp_id

    create_table :standards do |t|
      t.integer :jurisdiction_id, :required, :index
      t.column :csp_id, :string
      t.column :parent_ids, :integer, array: true, null: false, default: []
      t.column :education_levels, :string, array: true, null: false, default: []
      t.string :title
      t.string :subject
      t.column :document, :json
      t.column :indexed, :boolean, null:false, default: false
      t.foreign_key :jurisdictions
    end

    add_index :standards, :jurisdiction_id
    add_index :standards, :csp_id

  end
end
