# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    before_action :authenticate_admin!

    def index
      @items = Item.all
    end

    def update
      Item.find(params[:item_id]).update_promo(params[:discount_percentage])
      redirect_back(fallback_location: administration_items_path)
    end
  end
end
