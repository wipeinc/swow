require "spec_helper"

describe Swow::Client do
	let(:bnet_eu) { Swow::Client.new(ENV["BNET_API_KEY"], "eu", logger: false) }
	it "doesn't raise en error with a valid region" do
		expect { bnet_eu }.not_to raise_error
	end

	let(:xx) { Swow::Client.new(ENV["BNET_API_KEY"], "xx", logger: false) }
	it "raiase an error ith an invalid region" do
		expect { xx }.to raise_error("Invalid region xx")
	end

	describe "realm_status" do
		let(:eu_realm_status) { bnet_eu.realm_status }
		it "contains a realm array", :vcr do
			expect(eu_realm_status).to be_a(Hash)
			expect(eu_realm_status["realms"]).to be_a(Array)
		end
	end

	describe "character_profile" do
		let(:sweetlie) { bnet_eu.character_profile("Archimonde", "Sweetlie")}
		it "fetch basic information about character", :vcr do
			expect(sweetlie).to be_a(Hash)
			expect(sweetlie["name"]).to eq("Sweetlie")
		end

		context "field is set to one field" do
			context "the field is a valid field" do
				let(:character)  { bnet_eu.character_profile("Archimonde", "Sweetlie", fields: 'items')}
				it "fetch the field", :vcr do
					expect(character.has_key?("items")).to be true
				end
			end
		end

		context ":all fields param" do
			let(:character)  { bnet_eu.character_profile("Archimonde", "Sweetlie", fields: :all)}

			it "fetch all fields", :vcr do
				druid_fields = Swow::CHARACTER_FIELDS - [ "hunterPets"]
				expect(druid_fields.all? { |field| character.has_key?(field)} ).to be true
			end
		end
	end
end
