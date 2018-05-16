class ListsController < ApplicationController

    def new
        @list = List.new
    end
    def create
        @list = List.new(list_params)
        board = Board.find(params[:board_id])
        @list.board = board
        user = current_user
        respond_to do |format|
            if @list.save
                @user = user
                # Tell the UserMailer to send a welcome email after save
                ListMailerWorker.perform_async(@user.id, @list.id)
                format.html { redirect_to board_path(board), notice: 'List was successfully created.' }
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
        @list = List.find(params[:id])
        @list.destroy
        respond_to do |format|
          format.html { redirect_to board_path(params[:board_id]), notice: 'List was successfully destroyed.' }
          format.json { head :no_content }
        end
    end

    private

    def list_params
        params.require(:list).permit(:name, :board_id)
    end
end