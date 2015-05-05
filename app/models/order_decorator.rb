module Spree
  Order.class_eval do

    def has_address?
      bill_address.present? && ship_address.present?
    end
  end
end
