module Api
  module V1
    class MemoRelationsController < ApplicationController
      before_action :set_memo_relation, only: [:update, :destroy]
      
      def create
        @memo_relation = MemoRelation.new(memo_relation_params)
        if @memo_relation.save
          this_memo = Memo.find(memo_relation_params[:memo_id])
          @children_memos = this_memo.relations_and_children_memos
          render json: @children_memos
        end
      end
      
      def update
      end
      
      def destroy
        @memo_relation.destroy
      end
      
      private
        def set_memo_relation
          @memo_relation = MemoRelation.find(params[:id])
        end
        def memo_relation_params
          params.fetch(:memo_relation, {}).permit(:memo_id, :sub_memo_id, :semantic)
        end
    end
  end
end