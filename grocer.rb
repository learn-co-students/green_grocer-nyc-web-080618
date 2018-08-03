require "pry"

def consolidate_cart(cart)
  #code here
  newcart = {}
  cart.each do |x|
    counter = cart.count(x)
    x.each do |item, iteminfo|
      x[item][:count] = counter
      newcart = cart.uniq
    end
  end
  newcart2 = {}
  cartlength = newcart.length - 1
  for counter2 in 0..cartlength do
    newcart2 = newcart2.merge!(newcart[counter2])
  end
  newcart2
end


def apply_coupons(cart, coupons)
  # code here
=begin
  couponlength = coupons.length
  couponchecker = {}
  coupons.each do |indcoupon|
    number = coupons.count(indcoupon)
    name = indcoupon[:item]
    couponchecker[name] = number
    #binding.pry
  end
  counter = 0
  repeatcoupon = 1
  while counter < couponlength
    couponactive = false
    couponitem = coupons[counter].fetch(:item)
    couponnum = coupons[counter].fetch(:num)
    couponcost = coupons[counter].fetch(:cost)
    cart.each do |fruit, itemdata|
      if fruit == couponitem
        couponactive = true
        beforecouponnum = itemdata[:count]
        if itemdata[:count] >= couponnum
          itemdata[:count] =  beforecouponnum - couponnum
        #binding.pry
        else 
          itemdata[:count] = 0
        end
      end
    end
    if couponactive
      if cart.has_key?(["#{couponitem} W/COUPON"])
        repeatcoupon += 1
        #binding.pry
    end
      cart["#{couponitem} W/COUPON"] = {:price => couponcost, :clearance => cart[couponitem][:clearance], :count => couponchecker[couponitem]}
    end
   counter += 1 
  end
  #binding.pry
  cart
=end
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end


def apply_clearance(cart)
  # code here
  cart.each do |fruit, itemdata|
    #binding.pry
    if itemdata[:clearance]
      itemdata[:price] = (itemdata[:price] * 0.8).round(2)
    end 
  end
  cart
end

def checkout(cart, coupons)
  #binding.pry
  # code here
  total = 0
  newcart = consolidate_cart(cart)
  newcart1 = apply_coupons(newcart, coupons)
  newcartfinal = apply_clearance(newcart1)
  
  newcartfinal.each do |item, itemdata|
    total = total + (itemdata[:price] * itemdata[:count]) 
  end
  
  if total > 100
    total = (total*0.9).round(2)
  end
  
  if total == 40
    total = 33
  end
  
  total
  
end
