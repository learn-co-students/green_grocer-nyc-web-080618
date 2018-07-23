require "pry"
def consolidate_cart(cart)
    my_hash = {}
    counter = 1
    cart.each do |items|
      items.each do |key_value,specifics|
      end
    end
    cart.each do |cart_items|
      cart_items.each do |veggie,specifics|
        my_hash[veggie] = {}
        my_hash[veggie][:price] = cart_items[veggie][:price]
        my_hash[veggie][:clearance] = cart_items[veggie][:clearance]
        if !my_hash[veggie][:count]

          my_hash[veggie][:count] = counter
        else
          counter += 1
          my_hash[veggie][:count] = counter
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
            my_hash["#{coupon[:item]} W/COUPON"][:count] = counter
          else
            my_hash["#{coupon[:item]} W/COUPON"] = {}
            my_hash["#{coupon[:item]} W/COUPON"][:price] = coupon[:cost]
            my_hash["#{coupon[:item]} W/COUPON"][:clearance] = cart[coupon[:item]][:clearance]
            my_hash["#{coupon[:item]} W/COUPON"][:count] = counter

            my_hash[coupon[:item]][:count] = cart[coupon[:item]][:count] % coupon[:num]
          end
        end
      end
    #end

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
  cart = consolidate_cart(cart)
  puts "#{cart}"
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  cart.each do |key, variable|
    counter += cart[key][:price]
  end
  if counter > 100
    counter = counter - (counter * 0.10)
  end
  return counter
end
