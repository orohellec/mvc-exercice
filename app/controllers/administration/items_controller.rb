# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @items = Item.all
      puts params
    end

    def update
      Item.find(params[:item_id]).update_promo(params[:discount_percentage])
#      redirect_to administration_items_path
      redirect_back(fallback_location: administration_items_path)
    end
  end
end
