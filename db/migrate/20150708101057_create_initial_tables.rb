class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :jurisdictions, {id: false} do |t|
      t.string :id, :required, :index, unique: true
      t.string :title
      t.string :type
    end

    add_index :jurisdictions, :id, unique: true

    create_table :standard_sets, {id: false} do |t|
      t.string :id, :required, :index, unique: true
      t.string :jurisdiction_id, :required, :index
      t.string :title
      t.string :subject
      t.column :meta, :json
      t.foreign_key :jurisdictions
    end

    add_index :standard_sets, :id, unique: true
    add_index :standard_sets, :jurisdiction_id

    create_table :standards, {id: false} do |t|
      t.string :id, :required, :index, unique: true
      t.string :jurisdiction_id, :required, :index
      t.string :standard_set_id, :required, :index
      t.string :title
      t.string :subject
      t.column :meta, :json
      t.foreign_key :jurisdictions
      t.foreign_key :standard_sets
    end

    add_index :standards, :id, unique: true
    add_index :standards, :jurisdiction_id
    add_index :standards, :standard_set_id



  end
end
