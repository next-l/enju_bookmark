class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => [:show, :edit, :update, :destroy]
  authorize_resource :only => [:show, :edit, :update, :destroy]
  before_action :get_user
  after_action :solr_commit, :only => [:create, :update, :destroy]

  def index
    session[:params] ={} unless session[:params]
    session[:params][:tag] = params

    sort = {:sort_by => 'created_at', :order => 'desc'}
    case params[:sort_by]
    when 'name'
      sort[:sort_by] = 'name'
    when 'taggings_count'
      sort[:sort_by] = 'taggings_count'
    end
    sort[:order] = 'asc' if params[:order] == 'asc'

    query = @query = params[:query].to_s.strip
    page = params[:page] || 1

    @tags = Tag.search do
      fulltext query if query.present?
      paginate :page => page.to_i, :per_page => Tag.default_per_page
      order_by sort[:sort_by], sort[:order]
    end.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tags }
      format.rss
      format.atom
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tag }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, :notice => t('controller.successfully_updated', :model => t('activerecord.models.tag')) }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end

  private

  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end
end
