def consolidate_cart(cart)
  new_hash = {  }
  
  count_array = [ ]
  cart.each do |item|
    
    item.each do |item_name, traits|
      count_array.push(item_name)
  
  
  cart.each do |item|
   
    item.each do |item_name, traits|
     
      traits.each do |key, value|
        
        if new_hash[item_name] ==nil
           new_hash[item_name] = { } 
           new_hash[item_name][key] = value
        else
          new_hash[item_name][key] = value
          new_hash[item_name][:count] = count_array.count(item_name)
end        
end
end
end
end  
end 

new_hash
end

def apply_coupons(cart, coupons)

  coupon_count = [ ]
  coupons.each do |coupon|
    coupon_count.push(coupon[:item])
  end
  
  
  
  coupons.each do |coupon|
    
    if cart.keys.include?(coupon[:item]) == true && cart[coupon[:item]][:count] >= coupon[:num]
    if cart["#{coupon[:item]} W/COUPON"] == nil
    
       cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => [coupon_count.count(coupon[:item]),((cart[coupon[:item]][:count])/coupon[:num]).floor].min}
   
    coupon.each do |key, value|
   
      cart.each do |item_name, attributes|
       
        if key == :item && value == item_name && cart[item_name][:count] >= coupon[:num]
    
          cart[item_name][:count] = cart[item_name][:count] -( (coupon[:num])*(cart["#{coupon[:item]} W/COUPON"][:count] ))
          
end         
end      
end       
end  
end  
end

 cart
end

def apply_clearance(cart)
 
 cart.each do |item_name, attributes|
   if attributes[:clearance] == true
     attributes[:price] = (0.8*attributes[:price]).round(2)
   end
 end
 cart
end

def checkout(cart, coupons)
  updated_cart = consolidate_cart(cart)
 
  updated_cart = apply_coupons(updated_cart, coupons)
  updated_cart = apply_clearance(updated_cart)
  
  cost_array = [ ]
  
  updated_cart.each do |item_name, attributes|
    cost_array.push(attributes[:price]*attributes[:count])
  end 
  
  total_cost = 0
  cost_array.each do |price|
    total_cost = total_cost + price
  end
  
  if total_cost > 100
    total_cost = 0.9*total_cost
  end  
    

  total_cost
end
