require 'pry'

def consolidate_cart(cart)
  return_hash = {}
  cart.each do |item|
    item.each do |key1,value1|
      value1.each do |key2,value2|
        if return_hash[key1] == nil
          return_hash[key1] = {}
          return_hash[key1][key2] = value2
          return_hash[key1][:count] = 0
        else
          return_hash[key1][key2] = value2
        end
      end
      return_hash[key1][:count] += 1
    end
  end
  return_hash
end

def apply_coupons(cart,coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] != nil && cart[item][:count] >= coupon[:num]
      operative_hash = {
                        "#{item} W/COUPON" => { :price => coupon[:cost],
                        :clearance => cart[item][:clearance],
                        :count => 1 }
                      }
      if cart["#{item} W/COUPON"] != nil
        cart["#{item} W/COUPON"][:count] += 1
        cart[item][:count] -= coupon[:num]
      else
        cart["#{item} W/COUPON"] = operative_hash["#{item} W/COUPON"]
        cart[item][:count] -= coupon[:num]
      end
    end

  end
  cart
end

def apply_clearance(cart)
  return_hash = {}
  cart.each do |key1,value1|
    return_hash[key1] = value1
      if value1[:clearance] == true
        return_hash[key1][:price] = (value1[:price] * 0.8).round(1)
      end
  end
  return_hash
end

def checkout(cart, coupons)
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1,coupons)
  cart3 = apply_clearance(cart2)
  cart_total = 0
  cart3.each do |key,value|
    cart_total += value[:price] * value[:count]
  end

  if cart_total > 100
    cart_total = cart_total * 0.9
  end

  cart_total
end

#expects 22.60
