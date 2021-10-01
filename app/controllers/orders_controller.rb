class OrdersController < ApplicationController

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
  end

  private
  def order_params
    params.require(:order_address).permit(:postal_code, :area_id, :municipalities, :address, :building, :phone_num).merge(user_id: current_user.id, item_id: order.item.id)
  end

end
