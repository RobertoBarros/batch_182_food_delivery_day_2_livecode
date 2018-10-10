require 'csv'
require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'

require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'

require_relative 'app/repositories/order_repository'
require_relative 'app/controllers/orders_controller'

require_relative 'app/repositories/employee_repository'
require_relative 'app/controllers/sessions_controller'

meal_repository = MealRepository.new('data/meals.csv')
meals_controller = MealsController.new(meal_repository)

customer_repository = CustomerRepository.new('data/customers.csv')
customers_controller = CustomersController.new(customer_repository)

employee_repository = EmployeeRepository.new('data/employees.csv')
sessions_controller = SessionsController.new(employee_repository)

order_repository = OrderRepository.new('data/orders.csv', meal_repository, employee_repository, customer_repository)
orders_controller = OrdersController.new(meal_repository, employee_repository, customer_repository, order_repository)

require_relative 'router'

router = Router.new(meals_controller, customers_controller, sessions_controller, orders_controller)

router.run
