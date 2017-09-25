class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table(:employees) do |e|
      e.column(:name, :string)
    end
  end
end
