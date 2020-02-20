class CreateBpldcAuthorities < ActiveRecord::Migration[5.1]
  def change
    create_table :bpldc_authorities do |t|
      t.string :label
      t.string :code
      t.string :base_url
      t.boolean :subject, default: false
      t.boolean :genre, default: false
      t.boolean :name, default: false
      t.boolean :geographic, default: false

      t.timestamps
    end
  end
end
