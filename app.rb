require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/division")
require("./lib/employee")
require("pg")
require("pry")


get('/') do
  @divisions = Division.all()
  erb(:index)
end

post('/') do
  department = params.fetch("department")
  division = Division.new({:department => department})
  division.save
  @divisions = Division.all()
  erb(:index)
end

get('/divisions/:id') do
  @division = Division.find(params.fetch("id").to_i)
  @employees = @division.employees
  erb(:division)
end

post('/divisions/:id') do
  @division = Division.find(params.fetch("id").to_i)
  name = params.fetch("name")
  division_id = params.fetch("division_id").to_i
  employee = Employee.create({:name => name, :division_id => division_id})
  @employees = @division.employees
  erb(:division)
end

get('/divisions/:id/edit') do
  @division = Division.find(params.fetch("id").to_i)
  erb(:division_edit)
end

patch('/divisions/:id') do
  department = params.fetch("department")
  @division = Division.find(params.fetch("id").to_i)
  @division.update({:department => department})
  @employees = @division.employees
  erb(:division)
end

get('/employees/:id') do
  @employee = Employee.find(params.fetch("id").to_i)
  erb(:employee)
end

patch('/employees/:id') do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i)
  @employee.update({:name => name})
  erb(:employee)
end
