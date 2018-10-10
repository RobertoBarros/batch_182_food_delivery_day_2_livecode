class MealsView
  def ask_name
    puts "Enter meal name:"
    gets.chomp
  end

  def ask_price
    puts "Enter price:"
    gets.chomp.to_i
  end

  def list(meals)
    meals.each do |meal|
      puts "##{meal.id} #{meal.name} | R$ #{meal.price}"
    end
  end

end