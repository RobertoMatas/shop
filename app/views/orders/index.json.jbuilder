json.array!(@orders) do |order|
  json.extract! order, :id, :status, :payment_method, :shipping_address, :shipping_city, :customer_name, :customer_last_name
  json.url order_url(order, format: :json)
end
