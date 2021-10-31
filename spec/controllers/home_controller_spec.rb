require 'rails_helper'

RSpec.describe HomeController, type: :controller do

    describe "GET #index" do
        before do
            get :index
        end

        it :creates_link do
            expect(response).to be_successful
        end
    end
end