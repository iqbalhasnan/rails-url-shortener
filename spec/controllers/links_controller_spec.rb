require 'rails_helper'

RSpec.describe LinksController, type: :controller do

    describe "POST #create" do
        context "valid params" do
            let(:params) { { link: { url: 'http://google.com'} } }

            before do
                post :create, params: params, format: :js
            end

            it :creates_link do
                link = Link.last
        
                expect(link.url).to be_present
                expect(link.url).to eq 'http://google.com'
            end
        end
        context "invalid params" do
            let(:params) { { link: { url: ''} } }

            before do
                post :create, params: params, format: :js
            end

            it :does_not_create_link do
                link = Link.last
        
                expect(link).to be_nil
            end
        end
    end
end