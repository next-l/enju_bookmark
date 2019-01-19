# -*- encoding: utf-8 -*-
require 'rails_helper'

describe Bookmark do
  #pending "add some examples to (or delete) #{__FILE__}"
  fixtures :all

  it "should be shelved" do
    bookmarks(:bookmark_00001).shelved?.should be_truthy
  end

  it "should create bookmark with url" do
    old_manifestation_count = Manifestation.count
    old_item_count = Item.count
    lambda{
      bookmark = FactoryBot.create(:user).bookmarks.create(url: 'http://www.example.com/', title: 'test')
    }.should change(Bookmark, :count)
    Manifestation.count.should eq old_manifestation_count + 1
    Item.count.should eq old_item_count + 1
  end

  it "should create bookmark with local resource url" do
    old_manifestation_count = Manifestation.count
    old_item_count = Item.count
    lambda{
      bookmark = FactoryBot.create(:user).bookmarks.create(url: "#{LibraryGroup.site_config.url}manifestations/1", title: 'test')
    }.should change(Bookmark, :count)
    assert_equal old_manifestation_count, Manifestation.count
    assert_equal old_item_count, Item.count
  end

  it "should not create bookmark with local resource url" do
    old_manifestation_count = Manifestation.count
    old_item_count = Item.count
    lambda{
      bookmark = FactoryBot.create(:user).bookmarks.create(url: "#{LibraryGroup.site_config.url}libraries/1", title: 'test')
    }.should_not change(Bookmark, :count)
    assert_equal old_manifestation_count, Manifestation.count
    assert_equal old_item_count, Item.count
  end
end

# == Schema Information
#
# Table name: bookmarks
#
#  id               :bigint(8)        not null, primary key
#  user_id          :bigint(8)        not null
#  manifestation_id :bigint(8)        not null
#  title            :text
#  url              :string
#  note             :text
#  shared           :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
