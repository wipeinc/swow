require "spec_helper"

describe Swow::Fields do
  describe "initialize" do
    context "field is an array" do
      let(:fields) { [1, 2, 3] }
      it "set fields" do
        expect(Swow::Fields.new(fields, []).to_a).to eq(fields)
      end
    end
    context "field is not an array" do
      let(:fields) { "a" }
      it "convert field to an array" do
        expect(Swow::Fields.new(fields, []).to_a).to eq([fields])
      end
    end
    context "fields is :all" do
      let(:fields) { :all }
      let(:reference_fields) { [1, 2, 3] }
      it "set fields to refernce fields" do
        expect(Swow::Fields.new(fields, reference_fields).to_a).to eq(reference_fields)
      end
    end
  end

  describe "valid?" do
    context ""
  end
end
