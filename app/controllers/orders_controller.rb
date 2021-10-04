class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root_path
  before_action :set_item

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postal_code, :area_id, :municipalities, :address, :building, :phone_num).merge(
      token: params[:token], user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root_path
    set_item
    redirect_to root_path if current_user.id == @item.user.id || @item.order
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
