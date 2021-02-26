class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show,:edit,:update]
  
  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to  root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    unless @prototype.user.id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to  prototype_path
    else
      @prototype
      render  :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
      redirect_to  root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

end
