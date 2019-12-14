module Api
  module V1
    class MemosController < ApplicationController
      before_action :set_memo, only: [:show, :update, :destroy]
    
      # GET /memos
      def index
        if params[:date].present?
          date = JSON.parse(params[:date])
          start_date = date["start"]
          end_date = date["end"]
        else
          start_date = ""
          end_date = ""
        end
        query = {title_cont: params[:title], reference_cont: params[:reference], created_at_gteq: start_date, created_at_lteq: end_date, sorts: 'created_at desc'}
        
        if params[:exclude_ids].present?
          exclude_ids = params[:exclude_ids].map(&:to_i)
          @memo = Memo.ransack(query).result(distinct: true).where.not(id: exclude_ids)
        else
          @memo = Memo.ransack(query).result(distinct: true)
        end
        
        render json: @memo
      end
    
      # GET /memos/1
      def show
        relations_and_children_memos = @memo.relations_and_children_memos
        @children_memos = relations_and_children_memos
        render json: {memo: @memo, children_memos: @children_memos}
      end
    
      # POST /memos
      def create
        @memo = Memo.new(memo_params)
    
        if @memo.save
          render json: @memo, status: :created
        else
          render json: @memo.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /memos/1
      def update
        if @memo.update(memo_params)
          render json: @memo
        else
          render json: @memo.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /memos/1
      def destroy
        @memo.destroy
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_memo
          @memo = Memo.find(params[:id])
        end
    
        # Only allow a trusted parameter "white list" through.
        def memo_params
          params.fetch(:memo, {}).permit(:title, :main, :reference, :reference_other_details)
        end
        
    end
  end
end