class CustomersView
  def ask_name
    puts "Enter customer name:"
    gets.chomp
  end

  def ask_address
    puts "Enter address:"
    gets.chomp
  end

  def list(customers)
    customers.each do |customer|
      puts "(id: #{customer.id} #{customer.name} | Address #{customer.address})"
    end
  end

end