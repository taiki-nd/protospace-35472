class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :destroy, :new]
  before_action :move_to_index, except: [:index, :show]
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
    @comment = Comment.new 
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to action: :show
    else
      @prototype = Prototype.find(params[:id])
      render action: :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to action: :index
  end

  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end 

end
