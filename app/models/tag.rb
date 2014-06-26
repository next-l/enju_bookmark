class Tag < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :taggings, :dependent => :destroy, :class_name => 'ActsAsTaggableOn::Tagging'
  validates :name, :presence => true
  after_save :save_taggings
  after_destroy :save_taggings

  extend FriendlyId
  friendly_id :name

  settings do
    mappings dynamic: 'false', _routing: {required: false} do
      indexes :name
      indexes :created_at, type: 'date'
      indexes :updated_at, type: 'date'
      indexes :bookmark_ids, type: 'integer'
      indexes :taggings_count, type: 'integer'
    end
  end

  def as_indexed_json(options={})
    as_json.merge(
      bookmark_ids: tagged(Bookmark).compact.collect(&:id),
      taggings_count: taggings.size
    )
  end

  paginates_per 10

  def self.bookmarked(bookmark_ids, options = {})
    count = Tag.count
    count = Tag.default_per_page if count == 0
    unless bookmark_ids.empty?
      tags = Tag.search do
        with(:bookmark_ids).any_of bookmark_ids
        order_by :taggings_count, :desc
        paginate(:page => 1, :per_page => count)
      end.results
    end
  end

  def save_taggings
    self.taggings.collect(&:taggable).each do |t| t.save end
  end

  def tagged(taggable_type)
    self.taggings.where(:taggable_type => taggable_type.to_s).includes(:taggable).collect(&:taggable)
  end
end

# == Schema Information
#
# Table name: tags
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  name_transcription :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  taggings_count     :integer          default(0)
#
