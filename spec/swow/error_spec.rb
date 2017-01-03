require "spec_helper"

describe Swow::Error::RaiseError do
  let(:bnet_eu) { Swow::Client.new(ENV["BNET_API_KEY"], "eu", logger: false) }
  context "Character is not found" do
    subject {  bnet_eu.character_profile("Archimonde", "zzzz") }
    it "raise CharacterNotFound exception", :vcr do
      expect { subject }.to raise_error(Swow::CharacterNotFound)
    end
  end

  context "Realm is not found" do
    subject {  bnet_eu.character_profile("zzzz", "zzzz") }
    it "raise RealmNotFound exception", :vcr do
      expect { subject }.to raise_error(Swow::RealmNotFound)
    end
  end
end
