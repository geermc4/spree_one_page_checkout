module Spree
  class BuyController < Spree::StoreController
#    before_action :check_authorization
    before_action :load_order_with_lock
    before_action :forward_order, only: :edit

    def edit
    end

    private

#      def check_authorization
#        authorize!(:edit, current_order, cookies.signed[:guest_token])
#      end

      def load_order_with_lock
        @order = current_order(lock: true)
        redirect_to spree.cart_path and return unless @order && @order.line_items.present?
      end

      def forward_order
        while @order.next do
          if @order.state == "delivery"
            @order.shipments.each do |shipment|
              shipment.shipping_rates.update_all(selected: false)
              shipment.shipping_rates.where("cost > 0").sort_by(&:cost).first.update(selected: true)
              shipment.update_attributes_and_order(selected_shipping_rate: shipment.selected_shipping_rates)
            end
          end
        end
      end
  end
end
