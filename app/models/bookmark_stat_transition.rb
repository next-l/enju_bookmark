class BookmarkStatTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :bookmark_stat, inverse_of: :bookmark_stat_transitions
  attr_accessible :to_state, :sort_key, :metadata
end
