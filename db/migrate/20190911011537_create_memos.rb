class CreateMemos < ActiveRecord::Migration[6.0]
  def change
    create_table :memos do |t|
      t.string :title
      t.text :main
      t.text :reference
      t.text :reference_other_details
      t.timestamps
    end
  end
end
