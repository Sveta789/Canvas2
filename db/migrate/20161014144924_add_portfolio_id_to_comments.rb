class AddPortfolioIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :portfolio_id, :integer
  end
end
