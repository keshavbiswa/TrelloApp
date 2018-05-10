class BoardsController < ApplicationController
    before_action :authenticate_user!, :set_board, only: [:show, :edit, :update, :destroy]
    # access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit, :toggle_status]}, site_admin: :all
    
    # GET /boards/1
    # GET /boards/1.json
    def show
      @lists = @board.lists
      @lists.each do |list|
        @cards = list.cards.order("sort ASC")
      end
      @card = Card.new
    end
  
    # GET /boards/new
    def new
      @board = Board.new
    end
  
    # GET /boards/1/edit
    def edit
    end
  
    # POST /boards
    # POST /boards.json
    def create
      @board = Board.new(board_params)
      
      respond_to do |format|
        if @board.save
          current_user.boards << @board
          format.html { redirect_to @board, notice: 'board was successfully created.' }
          format.json { render :show, status: :created, location: @board }
        else
          format.html { render :new }
          format.json { render json: @board.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /boards/1
    # PATCH/PUT /boards/1.json
    def update
      respond_to do |format|
        if @board.update(board_params)
          format.html { redirect_to @board, notice: 'board was successfully updated.' }
          format.json { render :show, status: :ok, location: @board }
        else
          format.html { render :edit }
          format.json { render json: @board.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /boards/1
    # DELETE /boards/1.json
    def destroy
      @board.destroy
      respond_to do |format|
        format.html { redirect_to boards_url, notice: 'board was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_board
        @board = Board.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def board_params
        params.require(:board).permit(:name, :scope, :body)
      end
end
