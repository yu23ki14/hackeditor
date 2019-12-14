class CreateMemoRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :memo_relations do |t|
      t.references :memo, foreign_key: true
      t.references :sub_memo, foreign_key: {to_table: :memos}
      t.text :semantic
      t.timestamps
      
      t.index [:memo_id, :sub_memo_id], unique: true
    end
  end
end
