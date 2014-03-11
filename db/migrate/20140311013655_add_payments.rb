class AddPayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :amount
      t.string :cc_number
      t.string :expire_date
      t.timestamps
    end
  end
end
