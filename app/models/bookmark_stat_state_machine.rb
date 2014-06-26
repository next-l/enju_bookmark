class BookmarkStatStateMachine
  include Statesman::Machine
  state :pending, initial: true
  state :started
  state :completed

  transition from: :pending, to: [:started, :completed]

  after_transition(to: :started) do |bookmark_stat|
    bookmark_stat.calculate_count!
  end
end
