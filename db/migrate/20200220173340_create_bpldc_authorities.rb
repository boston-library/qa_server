class CreateBpldcAuthorities < ActiveRecord::Migration[5.1]
  def change
    create_table :bpldc_authorities do |t|
      t.string :name
      t.string :code, null: false
      t.string :base_url
      t.boolean :subjects, default: false
      t.boolean :genres, default: false
      t.boolean :names, default: false
      t.boolean :geographics, default: false

      t.timestamps
    end
  end
end
