class BookmarkStatTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :bookmark_stat, inverse_of: :bookmark_stat_transitions
end
