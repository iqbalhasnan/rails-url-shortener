require "rails_helper"

RSpec.describe CreateShortLinkForm do
  context "#valid?" do
    subject do
      described_class.new(
        url: link
      ).valid?
    end

    context "presence link" do
      let(:link) { "http://google.com" }

      it { expect(subject).to eq true }
    end

    context "empty link" do
      let(:link) { "" }

      it { expect(subject).to eq false }
    end

    context "invalid link" do
      let(:link) { "http://" }

      it { expect(subject).to eq false }
    end
  end

  context "#save" do
    context "valid link" do
      before do
        expect(TitleUpdaterJob).to receive(:perform_later)
      end

      it "saves and creates short link" do
        form = described_class.new(url: "http://google.com")

        form.save

        expect(form.short_link).to eql form.short_link
      end
    end

    context "invalid link" do
      before do
        expect(TitleUpdaterJob).not_to receive(:perform_later)
      end

      it "does not saved the link" do
        form = described_class.new(url: "")

        form.save

        expect(form.short_link).to eql nil
      end
    end
  end
end