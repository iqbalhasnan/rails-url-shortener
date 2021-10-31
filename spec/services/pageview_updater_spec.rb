require "rails_helper"

RSpec.describe PageviewUpdater do
  context "#create_pageview" do
    subject do
      described_class.for(slug, remote_ip)
    end

    context "valid short link slug" do
      let(:short_link) { create(:short_link) }
      let(:slug) { short_link.slug }
      let(:remote_ip) { "8.8.8.8" }

      it "creates pageview record" do

        expect(subject.remote_ip).to eq "8.8.8.8"
        expect(subject.geolocation).to eq "City,United States"
      end
    end

    context "invalid short link slug" do
      let(:slug) { "invalid-slug" }
      let(:remote_ip) { "8.8.8.8" }

      it "does not create pageview record" do

        expect(subject).to eq nil
      end
    end
  end
end