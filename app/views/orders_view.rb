class OrdersView

  def ask_meal_id
    puts "Enter meal ID:"
    gets.chomp.to_i
  end

  def ask_customer_id
    puts "Enter customer ID:"
    gets.chomp.to_i
  end

  def ask_employee_id
    puts "Enter employee ID:"
    gets.chomp.to_i
  end

  def ask_order_id
    puts "Enter order ID:"
    gets.chomp.to_i
  end

  def list(orders)
    orders.each do |order|
      puts "(##{order.id})  #{order.customer.name} ordered #{order.meal.name} delivered by #{order.employee.username}"
    end
  end

  def list_meals(meals)
    meals.each do |meal|
      puts "##{meal.id} #{meal.name} #{meal.price}"
    end
  end

  def list_customers(customers)
    customers.each do |customer|
      puts "##{customer.id} #{customer.name}"
    end
  end

  def list_delivery_guys(delivery_guys)
    delivery_guys.each do |delivery_guy|
      puts "##{delivery_guy.id} #{delivery_guy.username}"
    end
  end

end

