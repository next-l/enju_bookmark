require 'rails_helper'

describe ManifestationsController do
  fixtures :all

  def valid_attributes
    FactoryBot.attributes_for(:manifestation)
  end

  describe 'GET index', solr: true do
    before do
      Manifestation.reindex
    end

    describe 'When not logged in' do
      it 'should get tag_cloud' do
        get :index, params: { query: '2005', view: 'tag_cloud' }
        expect(response).to be_success
        expect(response).to render_template('manifestations/_tag_cloud')
      end
    end

    describe 'When not logged in' do
      it 'should show manifestation with tag_edit' do
        get :show, params: { id: 1, mode: 'tag_edit' }
        expect(response).to render_template('manifestations/_tag_edit')
        expect(response).to be_success
      end

      it 'should show manifestation with tag_list' do
        get :show, params: { id: 1, mode: 'tag_list' }
        expect(response).to render_template('manifestations/_tag_list')
        expect(response).to be_success
      end
    end
  end

  describe 'GET edit' do
    describe 'When logged in as User' do
      login_fixture_user

      it 'should edit manifestation with tag_edit' do
        get :edit, params: { id: 1, mode: 'tag_edit' }
        expect(response).to be_success
      end
    end
  end
end
