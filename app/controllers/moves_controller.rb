class MovesController < ApplicationController
  # GET /moves/new
  def new
    move = Move.new
    games = Game.where(id: params[:game_id])
    
    if games.any? and params[:position]
      game = games.first
      move.game = game
      move.player = current_user
      move.position = params[:position]
      move.current_user = current_user
      
      redirect = game_path(game)
      
      respond_to do |format|
        if move.save
          format.html { redirect_to redirect, notice: 'Move was successfully created.' }
          format.json { render :show, status: :created, location: move }
        else
          format.html { redirect_to redirect, flash: { danger: move.errors } }
          format.json { render json: move.errors, status: :unprocessable_entity }
        end
      end      
      
    else
      redirect_to games_path, alert: 'Invalid move.'
    end
    

    
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_move
      @move = Move.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def move_params
      params.require(:move).permit(:game_id, :position)
    end
end
