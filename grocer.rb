require 'pry'

def consolidate_cart(cart)
  merged_cart = {}
  cart.each do |item|
     item.each do |key,value|
    if merged_cart[key] == nil #accessing the key, return the value
      value[:count] = 1
      merged_cart[key] = value #new entry
    else
      merged_cart[key][:count] += 1
    end
    end
  end
    merged_cart
end

def apply_coupons(cart, coupons) #coupons are array of hash
  new_hash = {}

    cart.each do |key, value|
      if !coupons.empty?
       coupons.each do |coupon|
        if coupon[:item] == key && coupon[:num] <= value[:count]
        new_string = "#{key} W/COUPON"

        #binding.pry
        bundle_count = value[:count] / coupon[:num]

        new_hash[new_string] = {
          :price => coupon[:cost],
          :clearance => value[:clearance],
          :count => bundle_count}
          total_value = value[:count] % coupon[:num]
          value[:count] = total_value
          new_hash[key] = {
            :price => value[:price], :clearance => value[:clearance], :count => total_value
          }
          else
            new_hash[key] = value
          end
        end
    else
      new_hash[key] = value
  end
end
    new_hash
end

def apply_clearance(cart)
  cart.each do |key, value|
    if value[:clearance]
      price = value[:price] * 0.80
      value[:price] = price.round(2)
    end
  end
  # code here
end

def checkout(cart, coupons)

  new_cart = consolidate_cart(cart)
  coupon_deal = apply_coupons(new_cart, coupons)
  final_price = apply_clearance(coupon_deal)

  total = 0
  final_price.each do |k, v|
    total += v[:price] * v[:count]
  end

  if total > 100
    total = total * 0.9
  end
  total
end
