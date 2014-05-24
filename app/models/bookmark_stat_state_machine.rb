class BookmarkStatStateMachine
  include Statesman::Machine
  state :pending, initial: true
  state :completed

  transition from: :pending, to: :completed

  before_transition(to: :completed) do |bookmark_stat|
    bookmark_stat.calculate_count
  end
end
