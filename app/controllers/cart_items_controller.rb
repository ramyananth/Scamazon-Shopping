class CartItemsController < ApplicationController
  # before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  # def index
  #   @cart_items = CartItem.all
  # end

  # # GET /cart_items/1
  # # GET /cart_items/1.json
  # def show
  # end

  # # GET /cart_items/new
  # def new
  #   @cart_item = CartItem.new
  # end

  # # GET /cart_items/1/edit
  # def edit
  # end

  # POST /cart_items
  # POST /cart_items.json
  def create
    cart_item = current_user.cart.cart_items.where("item_id = ?", cart_items_params[:item_id]).first
    if cart_item.nil?
      cart_item = current_user.cart.cart_items.new(cart_items_params)
    #respond_to do |format|
      if cart_item.save
        #format.html { redirect_to @cart_item, notice: 'Cart item was successfully created.' }
        @cart = CartItem.where(cart_id: current_user.cart_id).order(created_at: :desc)
        render 'carts/show'
      else
        render cart_item.errors.full_messages, status: 422
      end 
    else
      cart_item.quantity += cart_items_params[:quantity].to_i
        if cart_item.save
          @cart = CartItem.where(cart_id: current_user.cart_id).order(created_at: :desc)
          render 'carts/show'

        else
          render cart_item.errors.full_messages, status: 422
        end
    end  
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    cart_item = current_user.cart.cart_items.where("item_id = ?", cart_items_params[:item_id]).first
    cart_item.quantity += cart_items_params[:quantity].to_i
    if cart_item.quantity < 1
      if cart_item.delete
        @cart = CartItem.where(cart_id: current_user.cart_id).order(created_at: :desc)
        render 'carts/show'
      else
        render json: ['no such product in the cart'], status: 404
      end
    else
      if cart_item.save
        @cart = CartItem.where(cart_id: current_user.cart_id).order(created_at: :desc)
        render 'carts/show'
      else
        render cart_item.errors.full_messages, status: 422
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    cart_item = CartItem.where(cart_id: current_user.cart_id).where("item_id = ?", cart_items_params[:item_id]).first
    if cart_item.delete
      @cart = CartItem.where(cart_id: current_user.cart_id).order(created_at: :desc)
      render 'carts/show'
    else
      render json: ['no such product in the cart'], status: 404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_cart_item
    #   @cart_item = CartItem.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def cart_items_params
      params.require(:cart_item).permit(:item_id, :quantity)
    end
end
