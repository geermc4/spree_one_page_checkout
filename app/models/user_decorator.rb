if Spree.user_class
  Spree.user_class.class_eval do
    after_create :generate_spree_api_key!
  end
end
