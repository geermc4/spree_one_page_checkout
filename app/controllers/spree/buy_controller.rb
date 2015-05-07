module Spree
  class BuyController < Spree::StoreController
    before_action :authenticate!

    before_action :load_order_with_lock
    before_action :forward_order, only: :edit
    before_action :set_step, only: :edit

    def edit
    end

    private
      def authenticate!
        authorize!(:edit, current_order, try_spree_current_user)
      end

      def load_order_with_lock
        @order = current_order(lock: true)
        redirect_to spree.cart_path and return unless @order && @order.line_items.present?
      end

      def forward_order
        set_address unless @order.has_address?
        return unless @order.has_address?

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

      def set_address
        addr = spree_current_user.bill_address || spree_current_user.ship_address

        @order.bill_address = (spree_current_user.bill_address || addr).try(:dup) || Spree::Address.default(try_spree_current_user, "bill")
        @order.ship_address = (spree_current_user.ship_address || addr).try(:dup) || Spree::Address.default(try_spree_current_user, "ship")
      end

      def set_step
        @step = params[:step] || "address"
      end
  end
end
