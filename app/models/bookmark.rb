# -*- encoding: utf-8 -*-
class Bookmark < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  scope :bookmarked, lambda {|start_date, end_date| where('created_at >= ? AND created_at < ?', start_date, end_date)}
  scope :user_bookmarks, lambda {|user| where(:user_id => user.id)}
  scope :shared, -> {where(:shared => true)}
  belongs_to :manifestation, :touch => true
  belongs_to :user #, :counter_cache => true, :validate => true

  validates_presence_of :user, :title
  validates_presence_of :url, :on => :create
  validates_presence_of :manifestation_id, :on => :update
  validates_associated :user, :manifestation
  validates_uniqueness_of :manifestation_id, :scope => :user_id
  validates :url, :url => true, :presence => true, :length => {:maximum => 255}
  before_save :create_manifestation, :if => :url_changed?
  validate :bookmarkable_url?
  validate :already_bookmarked?, :if => :url_changed?
  before_save :replace_space_in_tags
  after_destroy :reindex_manifestation

  acts_as_taggable_on :tags
  normalize_attributes :url

  index_name "#{name.downcase.pluralize}-#{Rails.env}"

  after_commit on: :create do
    index_document
  end

  after_commit on: :update do
    update_document
  end

  after_commit on: :destroy do
    delete_document
  end

  settings do
    mappings dynamic: 'false', _routing: {required: false} do
      indexes :title
      indexes :url
      indexes :tag
      indexes :user_id, type: 'integer'
      indexes :manifestation_id, type: 'integer'
      indexes :created_at, type: 'date'
      indexes :updated_at, type: 'date'
      indexes :shared, type: 'boolean'
    end
  end

  def as_indexed_json(options={})
    as_json.merge(
      title: manifestation.title,
      tag: tags.pluck(:name)
    )
  end

  paginates_per 10

  def replace_space_in_tags
    # タグに含まれている全角スペースを除去する
    self.tag_list = self.tag_list.map{|tag| tag.gsub('　', ' ').gsub(' ', ', ')}
  end

  def reindex_manifestation
    manifestation.__elasticsearch__.update_document if manifestation
  end

  def save_tagger
    #user.tag(self, :with => tag_list, :on => :tags)
    taggings.each do |tagging|
      tagging.tagger = user
      tagging.save(:validate => false)
    end
  end

  def shelved?
    true if manifestation.items.on_web.first
  end

  def self.get_title(string)
    CGI.unescape(string).strip unless string.nil?
  end

  def get_title
    return if url.blank?
    if url.my_host?
      my_host_resource.original_title
    else
      Bookmark.get_title_from_url(url)
    end
  end

  def self.get_title_from_url(url)
    return if url.blank?
    return unless Addressable::URI.parse(url).host
    if manifestation_id = url.bookmarkable_id
      manifestation = Manifestation.find(manifestation_id)
      return manifestation.original_title
    end
    unless manifestation
      normalized_url = Addressable::URI.parse(url).normalize.to_s
      doc = Nokogiri::HTML(open(normalized_url).read)
      # TODO: 日本語以外
      #charsets = ['iso-2022-jp', 'euc-jp', 'shift_jis', 'iso-8859-1']
      #if charsets.include?(page.charset.downcase)
        title = NKF.nkf('-w', CGI.unescapeHTML((doc.at("title").inner_text))).to_s.gsub(/\r\n|\r|\n/, '').gsub(/\s+/, ' ').strip
        if title.blank?
          title = url
        end
      #else
      #  title = (doc/"title").inner_text
      #end
      title
    end
  rescue OpenURI::HTTPError
    # TODO: 404などの場合の処理
    raise "unable to access: #{url}"
  #  nil
  end

  def self.get_canonical_url(url)
    doc = Nokogiri::HTML(open(url))
    canonical_url = doc.search("/html/head/link[@rel='canonical']").first['href']
    # TODO: URLを相対指定している時
    Addressable::URI.parse(canonical_url).normalize.to_s
  rescue
    nil
  end

  def my_host_resource
    if url.bookmarkable_id
      manifestation = Manifestation.find(url.bookmarkable_id)
    end
  end

  def bookmarkable_url?
    if url.try(:my_host?)
      unless url.try(:bookmarkable_id)
        errors[:base] << I18n.t('bookmark.not_our_holding')
      end
      unless my_host_resource
        errors[:base] << I18n.t('bookmark.not_our_holding')
      end
    end
  end

  def get_manifestation
    # 自館のページをブックマークする場合
    if url.try(:my_host?)
      manifestation = self.my_host_resource
    else
      manifestation = Manifestation.where(:access_address => self.url).first if self.url.present?
    end
  end

  def already_bookmarked?
    if manifestation
      if manifestation.bookmarked?(user)
        errors[:base] << 'already_bookmarked'
      end
    end
  end

  def create_manifestation
    manifestation = get_manifestation
    if manifestation
      self.manifestation_id = manifestation.id
      return
    end
    manifestation = Manifestation.new(:access_address => url)
    manifestation.carrier_type = CarrierType.where(:name => 'file').first
    if self.title.present?
      manifestation.original_title = self.title
    else
      manifestation.original_title = self.get_title
    end
    Manifestation.transaction do
      manifestation.save
      self.manifestation = manifestation
      item = Item.new(
        :manifestation_id => manifestation.id
      )
      item.shelf = Shelf.web
      item.manifestation = manifestation
      if defined?(EnjuCirculation)
        item.circulation_status = CirculationStatus.where(:name => 'Not Available').first
      end

      item.save!
      if defined?(EnjuCirculation)
        item.use_restriction = UseRestriction.where(:name => 'Not For Loan').first
      end
    end
  end

  def self.manifestations_count(start_date, end_date, manifestation)
    if manifestation
      self.bookmarked(start_date, end_date).where(:manifestation_id => manifestation.id).count
    else
      0
    end
  end

  def create_tag_index
    taggings.each do |tagging|
      Tag.find(tagging.tag_id).__elasticsearch__.update_document
    end
  end

end

# == Schema Information
#
# Table name: bookmarks
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  manifestation_id :integer
#  title            :text
#  url              :string(255)
#  note             :text
#  shared           :boolean
#  created_at       :datetime
#  updated_at       :datetime
#
