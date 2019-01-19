class AddExpireDateToReserve < ActiveRecord::Migration[5.2]
  def self.up
    add_column :reserves, :expire_date, :string
  end

  def self.down
    remove_column :reserves, :expire_date
  end
end
