class ListsController < ApplicationController
  before_action :authenticate_inn_owner!

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end
  def new
    @list = List.new

  end

  def create
    lists_params = params.require(:list).permit(:name)

    @list = List.new(lists_params)

    @list.inn_owner = current_inn_owner

    if @list.save
      redirect_to @list, notice: 'Lista criada com sucesso.'
    else
      flash.now[:notice] = 'Nome não pode ficar em branco'
      render :new, status: :unprocessable_entity
    end
  end
  
end