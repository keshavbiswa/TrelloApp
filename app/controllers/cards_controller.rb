class CardsController < ApplicationController
  def sort
    params[:order].each do |key, value|
      Card.find(value[:id]).update!(sort: value[:position])
      puts value
    end
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
        format.json { render :show, status: :created, location: @Card }
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
    @card.destroy
    respond_to do |format|
      format.html { redirect_to board_path(params[:board_id]), notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def card_params
        params.require(:card).permit(:name,:list_id)
    end
end
