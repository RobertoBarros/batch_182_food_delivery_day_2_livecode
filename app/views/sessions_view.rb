class SessionsView

  def ask_username
    puts "username?"
    gets.chomp
  end

  def ask_password
    puts "password"
    gets.chomp
  end

  def welcome_message(employee)
    puts "Welcome #{employee.username}"
  end

  def wrong
    puts "Wrong Credentials"
  end
end