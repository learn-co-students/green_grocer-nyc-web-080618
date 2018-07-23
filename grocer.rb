require "pry"
def consolidate_cart(cart)
  count = 0
  my_hash = {}
  comparisons_array = []
  cart.each do |object|
    object.each do |veggie, attributes|
      object[veggie][:count] = 0
      comparisons_array.push(veggie)
    end
  end
  cart.each do |object|
    object.each do |veggie, attribute|
      counter = 0
      comparisons_array.each_index do |index|
        if comparisons_array[index] == veggie
          counter += 1
          end
        end
        object[veggie][:count] = counter
      end
    end
  cart.each do |object|
    object.each do |key1, value1|
      my_hash[key1] = value1
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
    coupon.each do |variables, particulars|
      cart.each do |veggie, specifics|
      if veggie == coupon[:item]
        if my_hash["#{veggie} W/COUPON"] == {}
          counter = counter + 1
          my_hash["#{veggie} W/COUPON"][:count] = counter
        else
        my_hash["#{veggie} W/COUPON"] = {}
        my_hash["#{veggie} W/COUPON"][:price] = coupon[:cost]
        my_hash["#{veggie} W/COUPON"][:clearance] = cart[veggie][:clearance]
        my_hash["#{veggie} W/COUPON"][:count] = counter

        my_hash[veggie][:count] = cart[veggie][:count] % coupon[:num]
      end
        end
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
  cart = consolidate_cart(cart)
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
