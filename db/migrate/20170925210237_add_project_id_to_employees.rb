class AddProjectIdToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column(:employees, :project_id, :integer)
  end
end
