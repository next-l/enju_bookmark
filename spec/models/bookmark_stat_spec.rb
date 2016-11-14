# -*- encoding: utf-8 -*-
require 'rails_helper'

describe BookmarkStat do
  fixtures :bookmark_stats

  it 'calculates manifestation count' do
    bookmark_stats(:bookmark_stat_00001).transition_to!(:started).should be_truthy
  end
end

# == Schema Information
#
# Table name: bookmark_stats
#
#  id           :integer          not null, primary key
#  start_date   :datetime
#  end_date     :datetime
#  started_at   :datetime
#  completed_at :datetime
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#
