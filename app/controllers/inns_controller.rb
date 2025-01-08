class InnsController < ApplicationController
  def show
    @inn = Inn.find(params[:id])
  end

  def favorite
    @inn = Inn.find(params[:inn_id])

    current_list = current_inn_owner.lists.first
    current_list << @inn 
    
  end
end