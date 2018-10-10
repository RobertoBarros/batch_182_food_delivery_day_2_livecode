require_relative '../models/customer'

class CustomerRepository
  CSV_OPTIONS = { headers: :first_row, header_converters: :symbol }

  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    load_csv
  end

  def add(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  def all
    @customers
  end

  def find(id)
    @customers.select { |customer| customer.id == id }.first
  end


  def load_csv
    if File.exist?(@csv_file)
      CSV.foreach(@csv_file, CSV_OPTIONS) do |row|
        customer = Customer.new(id: row[:id].to_i, name: row[:name], address: row[:address])
        @customers << customer
      end
    end

    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb', CSV_OPTIONS) do |file|
      file << [:id, :name, :address]
      @customers.each do |customer|
        file << [customer.id, customer.name, customer.address]
      end
    end
  end


end