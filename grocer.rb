def consolidate_cart(cart)
  result = {}
  cart.each_with_index do |item, i|
    item.each do |food, info|
      if result[food]
        result[food][:count] += 1
      else
        result[food] = info
        result[food][:count] = 1
      end
    end
  end
  result
end

def apply_coupons(cart, coupons)
  result = {}
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  end
  result
end

def apply_clearance(cart)
  clearance_cart = {}
  cart.each do |food, info|
    clearance_cart[food] = {}
    if info[:clearance] == true
      clearance_cart[food][:price] = info[:price] * 4 / 5
    else
      clearance_cart[food][:price] = info[:price]
    end
    clearance_cart[food][:clearance] = info[:clearance]
    clearance_cart[food][:count] = info[:count]
  end
  clearance_cart
end


def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total = total * 0.9 if total > 100
  total
end 
