class AddMostRecentToUserCheckoutStatTransitions < ActiveRecord::Migration[5.2]
  def up
    add_column :user_checkout_stat_transitions, :most_recent, :boolean, null: true
  end

  def down
    remove_column :user_checkout_stat_transitions, :most_recent
  end
end
