class BookmarkStatTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :bookmark_stat, inverse_of: :bookmark_stat_transitions
  attr_accessible :to_state, :sort_key, :metadata
end

# == Schema Information
#
# Table name: bookmark_stat_transitions
#
#  id               :integer          not null, primary key
#  to_state         :string(255)
#  metadata         :text             default("{}")
#  sort_key         :integer
#  bookmark_stat_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
