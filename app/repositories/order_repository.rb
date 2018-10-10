require_relative '../models/order'

class OrderRepository
  CSV_OPTIONS = { headers: :first_row, header_converters: :symbol }

  def initialize(csv_file, meal_repository, employee_repository, customer_repository)
    @customer_repository = customer_repository
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @csv_file = csv_file
    @orders = []
    load_csv
  end

  def add(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def all
    @orders
  end

  def find(id)
    @orders.select { |order| order.id == id }.first
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def find_by_employee(employee)
    @orders.select { |order| order.employee.id == employee.id }
  end


  def load_csv
    if File.exist?(@csv_file)
      CSV.foreach(@csv_file, CSV_OPTIONS) do |row|
        customer_id = row[:customer_id].to_i
        customer = @customer_repository.find(customer_id)

        meal_id = row[:meal_id].to_i
        meal = @meal_repository.find(meal_id)

        employee_id = row[:employee_id].to_i
        employee = @employee_repository.find(employee_id)

        order = Order.new(id: row[:id].to_i, delivered: row[:delivered] == 'true', customer: customer, meal: meal, employee: employee)

        @orders << order
      end
    end

    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb', CSV_OPTIONS) do |file|
      file << [:id, :delivered, :customer_id, :meal_id, :employee_id]
      @orders.each do |order|
        file << [order.id, order.delivered, order.customer.id, order.meal.id, order.employee.id]
      end
    end
  end


end