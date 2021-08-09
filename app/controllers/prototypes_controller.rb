class PrototypesController < ApplicationController

  def index
    query = "SELECT * FROM prototypes ORDER BY created_at desc"
    @prototypes = Prototype.find_by_sql(query)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
  end

  def edit

  end

  def update
    
  end

  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end
  
end
