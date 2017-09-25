class CreateDivisions < ActiveRecord::Migration[5.1]
  def change
    create_table(:divisions) do |d|
      d.column(:department, :string)
      d.column(:employee_id, :integer)
    end
  end
end
