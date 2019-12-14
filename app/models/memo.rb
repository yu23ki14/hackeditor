class Memo < ApplicationRecord
  has_many :memo_relations
  
  def relations_and_children_memos
    relations = self.memo_relations
    id_list = relations.map{|memo| memo.sub_memo_id}
    children_memos = Memo.where(id: id_list).includes(:memo_relations)
    
    children_relations = []
    children_memos.each do |child_memo|
      children_relations.push(child_memo.memo_relations.length)
    end
      
    return {memos: children_memos, relations: relations, children_relations: children_relations}
  end
end
