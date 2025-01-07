class ListsController < ApplicationController

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
      # tratar falha
      puts('Falha ao criar')
    end
  end
  
end