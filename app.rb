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
