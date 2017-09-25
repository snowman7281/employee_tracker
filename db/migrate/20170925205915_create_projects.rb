class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table(:projects) do |p|
      p.column(:title, :string)
      p.column(:employee_id, :integer)
    end
  end
end
