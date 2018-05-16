class CardsController < ApplicationController
  def sort
    Card.find(params["task"]["id"]).update!(sort: params["task"]["sort"], list_id: params["task"]["list_id"])
    
    render body: nil
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    list = List.find(params[:list_id])
    @card.list = list
    respond_to do |format|
      if @card.save
        format.html { redirect_to board_path(params[:board_id]), notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @card = Card.find(params[:id])
    board = Board.find(params[:board_id])
      if @board.author_id == current_user.id
      @card.destroy
      respond_to do |format|
        format.html { redirect_to board_path(params[:board_id]), notice: 'Card was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

    def card_params
        params.require(:card).permit(:name,:list_id)
    end
end
