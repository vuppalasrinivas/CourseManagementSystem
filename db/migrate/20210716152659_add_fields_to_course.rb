class AddFieldsToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :short_description, :string
    add_column :courses, :price, :integer
  end
end
