require 'rails_helper'

RSpec.describe ShortLinksController, type: :controller do

    describe "GET #show" do
        context "valid slug" do
            let(:short_link) { create(:short_link) }

            before do
                get :show, params: { id: short_link.slug }
            end

            it :renders_redirect_message_response_body do
                expect(response.body).to match("<html><body>You are being <a href=\"#{short_link.link.url}\">redirected</a>.</body></html>")
            end
        end
        context "invalid slug" do
            before do
                get :show, params: { id: "invalid-slug" }
            end

            it :renders_empty_response_body do
                expect(response.body).to match("")
            end
        end
    end
end