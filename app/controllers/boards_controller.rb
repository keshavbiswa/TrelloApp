class BoardsController < ApplicationController
    before_action :authenticate_user!, :set_board, only: [:show, :edit, :update, :destroy, :insert]
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
      user = current_user
      respond_to do |format|
        if user.boards.exists?(name: @board.name)
          format.html { redirect_to root_path, notice: 'Board is already present.' }
        elsif @board.save
          user.boards << @board
          @user = user
          # Tell the UserMailer to send a welcome email after save
          BoardMailerWorker.perform_async(@user.id, @board.id)
          format.html { redirect_to @board, notice: 'Board was successfully created.' }
          format.json { render :show, status: :created, location: @board }
        else
          format.html { render :new }
          format.json { render json: @board.errors, status: :unprocessable_entity }
        end
      end
    end

    def insert
      user = User.where(name: params["board"]["term"]).take
      respond_to do |format|
        if user
          if @board.users.exists?(name: user.name)
            format.html {redirect_to root_path, notice: 'The user is already a member of the board.'} 
          else
            @board.users << user
            MemberMailerWorker.perform_async(user.id, @board.id)
            format.html {redirect_to root_path, notice: 'Member was succesfully updated.'}
          end

        else
          format.html { redirect_to root_path, notice: 'Member with that name does not exists.' }
        end
      end
    end
  
    # PATCH/PUT /boards/1
    # PATCH/PUT /boards/1.json
    def update
      respond_to do |format|
        if @board.update(board_params)
          format.html { redirect_to @board, notice: 'Board was successfully updated.' }
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
      if @board.author_id == current_user.id
        @board.destroy
        respond_to do |format|
          format.html { redirect_to root_path, notice: 'Board was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    end

    def add
      @board = Board.find(params[:board_id])
      @users = User.all
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_board
        @board = Board.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def board_params
        params.require(:board).permit(:name, :scope, :body, :author_id)
      end
end
