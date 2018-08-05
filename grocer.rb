require 'pry'


def consolidate_cart(cart)
  cart_hash = {}
  
  cart.each do |item|
    #binding.pry
      item.each do |item_name, item_info|
        #binding.pry
          cart_hash[item_name] ||= item_info
          cart_hash[item_name][:count] ||= 0
          cart_hash[item_name][:count] += 1
      end
  end
  cart_hash
end



def apply_coupons(cart, coupons)
  coupons.each do |discount|
    #binding.pry
    coupon = discount[:item]
    if cart[coupon] && cart[coupon][:count] >= discount[:num]
      if cart["#{coupon} W/COUPON"]
        cart["#{coupon} W/COUPON"][:count] += 1
      else
        cart["#{coupon} W/COUPON"] = {:count => 1, :price => discount[:cost]}
        cart["#{coupon} W/COUPON"][:clearance] = cart[coupon][:clearance]
      end
      cart[coupon][:count] -= discount[:num]
    end
  end
  cart
end



def apply_clearance(cart)
  cart.each do |item, item_info|
    #binding.pry
      if item_info[:clearance] == true
       item_info[:price] = (item_info[:price]*0.80).round(3)
      end
  end
  cart
end




def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  you_pay = 0
  
  final_cart.each do |item, item_info|
    #binding.pry
      you_pay += item_info[:price] * item_info[:count]
  end
  
  you_pay = you_pay * 0.9 if you_pay > 100
  you_pay
end