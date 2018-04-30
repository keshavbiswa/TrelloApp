class ListsController < ApplicationController

    def new
        @list = List.new
    end
    def create
        @list = List.new(list_params)
        board = Board.find(params[:board_id])
        @list.board = board
        respond_to do |format|
            if @list.save
            format.html { redirect_to root_path, notice: 'List was successfully created.' }
            format.json { render :show, status: :created, location: @List }
            else
            format.html { render :new }
            format.json { render json: @list.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        @list = List.find(params[:id])
    end

    def update
    end

    def destroy
    end

    private

    def list_params
        params.require(:list).permit(:name, :board_id)
    end
end