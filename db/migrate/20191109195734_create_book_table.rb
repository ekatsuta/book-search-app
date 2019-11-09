class CreateBookTable < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.integer :index
      t.string :title
      t.string :author
      t.string :publishing_company
    end
  end
end
