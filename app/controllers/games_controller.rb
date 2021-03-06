class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = current_user.games.select { |game| game.status == 'In progress' }
  end

  # GET /games/1
  # GET /games/1.json
  def show
    if request.xhr?
      render partial: 'game_board', locals: { game: @game }
    else
      render :show
    end    
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end
  
  def rematch
    @game = Game.find(params[:game_id])
    other_players = @game.players.select{|player| player != current_user}
    @new_game = Game.new
    @new_game.player1 = current_user
    @new_game.player2 = other_players.first
    @new_game.status = 'In progress'
    if @new_game.save
      redirect_to game_path @new_game, notice: 'Game created.  Your turn.'
    else
      redirect_to new_game_path
    end
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    
    player2 = User.where(username: params[:game][:player2])
    if player2.any?
    @game.player2_id = player2.first.id 
    else
      return redirect_to new_game_path, flash: { danger: "Can't find that player" }
    end
    
    @game.player1_id = current_user.id
    @game.status = "In progress"    
      
    return redirect_to games_path, flash: { danger: "Don't be silly." } if @game.player2 == @game.player1
    
    respond_to do |format|
      if @game.save
        format.html { redirect_to games_path, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:player2_id)
    end
end
