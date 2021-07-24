require "rails_helper"

RSpec.describe PlaceCrawlerJob, type: :job do
  it "calls the crawler service" do
    perform_enqueued_jobs do
      expect(Place::Crawler).to receive(:call)
        .with("Central Park", 1, 2)
      described_class.perform_later "Central Park", 1, 2
    end
  end
end
