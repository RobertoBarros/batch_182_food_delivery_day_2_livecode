require_relative '../models/meal'

class MealRepository
  CSV_OPTIONS = { headers: :first_row, header_converters: :symbol }

  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    load_csv
  end

  def add(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.select { |meal| meal.id == id }.first
  end


  def load_csv
    if File.exist?(@csv_file)
      CSV.foreach(@csv_file, CSV_OPTIONS) do |row|
        meal = Meal.new(id: row[:id].to_i, name: row[:name], price: row[:price].to_i)
        @meals << meal
      end
    end

    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb', CSV_OPTIONS) do |file|
      file << [:id, :name, :price]
      @meals.each do |meal|
        file << [meal.id, meal.name, meal.price]
      end
    end
  end


end