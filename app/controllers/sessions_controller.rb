require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def sign_in
    username = @view.ask_username
    password = @view.ask_password

    employee = @employee_repository.find_by_username(username)

    if employee && employee.password == password
      @view.welcome_message(employee)
      return employee
    else
      @view.wrong
      sign_in
    end

  end
end