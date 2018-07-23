

require "pry"
def consolidate_cart(cart)

    my_hash = {}
    cart.each do |cart_items|
      cart_items.each do |veggie,specifics|
        if !my_hash[veggie]
          my_hash[veggie] = {}
        my_hash[veggie][:price] = cart_items[veggie][:price]
        my_hash[veggie][:clearance] = cart_items[veggie][:clearance]
        end
        if !my_hash[veggie][:count]
          my_hash[veggie][:count] = 1
        else
          my_hash[veggie][:count] += 1
        end
      end
    end
  return my_hash
end

def apply_coupons(cart, coupons)

  my_hash = {}
  counter = 1
  if coupons == []
    return cart
  end
    coupon_counter = 0

  coupons.each do |coupon|
    cart.each do |key, value|
      if coupon[:item] == "BEER"
        coupon_counter += coupon[:num]
        if cart[key][:count] < coupon_counter
          coupons[1] = {}
          end
        end
      end
    end


puts "#{coupons}"











  coupons.each do |coupon|
    coupon.each do |variables, particulars|
      cart.each do |veggie, specifics|
        my_hash[veggie] = specifics
      end
    end
  end
  coupons.each do |coupon|
  #  coupon.each do |variables, particulars|
        #binding.pry
        if cart[coupon[:item]]
          if my_hash["#{coupon[:item]} W/COUPON"]
            counter += 1
            my_hash["#{coupon[:item]} W/COUPON"][:count] += 1
          else
            my_hash["#{coupon[:item]} W/COUPON"] = {}
            my_hash["#{coupon[:item]} W/COUPON"][:price] = coupon[:cost]
            my_hash["#{coupon[:item]} W/COUPON"][:clearance] = cart[coupon[:item]][:clearance]
            my_hash["#{coupon[:item]} W/COUPON"][:count] = 1

            my_hash[coupon[:item]][:count] = cart[coupon[:item]][:count] % coupon[:num]
          end
        end
      end
















  return my_hash
end

def apply_clearance(cart)
  cart.each do |key1,variable1|
    if cart[key1][:clearance] == true
      cart[key1][:price] = (cart[key1][:price] - (cart[key1][:price] * 0.2))
    end
  end
end

def checkout(cart,coupons)


  counter = 0
  consolidated_cart = consolidate_cart(cart)

  #coupons = remove_extra_coupon(consolidated_cart,cart)
  puts "#{coupons}"
  cart_with_coupons = apply_coupons(consolidated_cart,coupons)
  applied_clearance_cart = apply_clearance(cart_with_coupons)


  applied_clearance_cart.each do |key1, value1|
    counter += applied_clearance_cart[key1][:price] * applied_clearance_cart[key1][:count]
  end


  if counter > 100
    counter = counter - (counter * 0.10)
  end
  return counter
end
