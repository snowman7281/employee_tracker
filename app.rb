require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/division")
require("./lib/employee")
require("./lib/project")
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

get('/employees') do
  @employees = Employee.all
  erb(:employees)
end

get('/employees/:id') do
  @employee = Employee.find(params.fetch("id").to_i)
  erb(:employee)
end

post('/employees/:id') do
  @employee = Employee.find(params.fetch("id").to_i)
  title = params.fetch("title")
  employee_id = params.fetch("employee_id").to_i
  project = Project.create({:title => title, :employee_id => employee_id})
  @employee.update({:project_id => project.id})
  erb(:employee)
end

patch('/employees/:id') do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i)
  @employee.update({:name => name})
  erb(:employee)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

post('/projects') do
  title = params.fetch("title")
  project = Project.create({:title => title})
  @projects = Project.all()
  erb(:projects)
end

get('/projects/:id') do
  @project = Project.find(params.fetch("id").to_i)
  @employees = @project.employees
  erb(:project)
end

post('/projects/:id') do
  @project = Project.find(params.fetch("id").to_i)
  name = params.fetch("name")
  project_id = params.fetch("project_id")
  employee = Employee.create({:name => name, :project_id => project_id})
  @project.update({:employee_id => employee.id})
  @employees = @project.employees
  erb(:project)
end

delete('/:id') do
   @division = Division.find(params.fetch('id').to_i)
   Division.destroy(@division.id)
   @divisions = Division.all()
   erb(:index)
 end

 patch('/projects/edit/:id') do
   @employee = Employee.find(params.fetch("id").to_i)
   @employee.update({:project_id => nil})
   erb(:employee)
 end
