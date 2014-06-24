# -*- encoding: utf-8 -*-
require 'spec_helper'

describe BookmarkStat do
  fixtures :bookmark_stats

  it "calculates manifestation count" do
    bookmark_stats(:bookmark_stat_00001).transition_to!(:started).should be_true
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
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

