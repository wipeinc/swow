require "spec_helper"

describe Swow::ParseTimestamps do
  let(:timestamp_parser) {  Swow::ParseTimestamps.new(nil) }
  describe "timestamp convertions" do
    let(:time) { Time.new(2010, 1, 1) }
    let(:bnet_timestamp) {  timestamp_parser.bnet_timestamp(time.to_i) }
    it "can convert back and forth battle net timestamp" do
      expect(timestamp_parser.parse_bnet_timestamp(bnet_timestamp)).to eq(time)
    end
  end

  describe "is_a_timestamp" do
    context "value is a valid timestamp" do
      subject  { timestamp_parser.is_a_timestamp?(1487035835000) }
      it { is_expected.to be_truthy }
    end

    context "value is an invalid number" do
      subject  { timestamp_parser.is_a_timestamp?(12345) }
      it { is_expected.to be_falsey }
    end

    context "value is not a number" do
      subject  { timestamp_parser.is_a_timestamp?("ab") }
      it { is_expected.to be_falsey }
    end
  end

  describe "replace_timestamps" do
    let(:auctions) {{
      "files": [{
          "url": "http://auction-api-eu.worldofwarcraft.com",
          "lastModified": 1487035835000
      }]
    }}
    let(:auction_parsed)  {{
      "files": [{
          "url": "http://auction-api-eu.worldofwarcraft.com",
          "lastModified": Time.at(1487035835000 / 1000)
      }]
    }}
    subject { timestamp_parser.parse_timestamps!(auctions) }
    it "replace timestamp by a Time in a hash" do
      expect(subject).to eq(auction_parsed)
    end

  end

  describe "complete auction fetch" do
    let(:bnet_eu) { Swow::Client.new(ENV["BNET_API_KEY"], "eu", logger: false) }
    subject { bnet_eu.auction_data_status("Archimonde") }
    it "has is lastModified field converted to a Time class", :vcr do
      expect(subject["files"][0]["lastModified"]).to be_a Time
    end
  end
end
