require "rails_helper"

RSpec.describe TitleUpdater, :vcr do
  context "#update_title" do
    subject do
      described_class.new(slug)
    end

    context "valid short link slug with nill title" do
      let(:link) { create(:link, url: "http://example.com/", title: nil)}
      let(:short_link) { create(:short_link, link: link) }
      let(:slug) { short_link.slug }

      it "updates the title" do
        expect do
          subject.update_title
        end.to change { link.reload.title }.from(nil).to("Example Domain")
      end
    end

    context "valid short link slug with already existing title" do
      let(:link) { create(:link, url: "http://example.com/", title: "Example Domain")}
      let(:short_link) { create(:short_link, link: link) }
      let(:slug) { short_link.slug }

      it "should not update the title" do
        expect do
          subject.update_title
        end.not_to change { link.reload.title }
      end
    end
  end
end