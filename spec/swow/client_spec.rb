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
end