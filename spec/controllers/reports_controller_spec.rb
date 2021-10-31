require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

    describe "GET #index" do
        let(:short_link) { create(:short_link) }

        before do
            get :index, params: { slug: short_link.slug }
        end

        it :renders_redirect_message_response_body do
            expect(response).to be_successful
        end
    end
end