class AddDefaultToMoneyColumns < ActiveRecord::Migration
  def change
  	change_column_default :borrowers, :money, 0
  end
end
