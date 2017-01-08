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
      it "set fields to reference fields" do
        expect(Swow::Fields.new(fields, reference_fields).to_a).to eq(reference_fields)
      end
    end
  end

  describe "valid?" do
    context "fields are contained in reference fields" do
      let(:fields) { [1, 3] }
      let(:reference_fields) { [1, 2, 3] }
      subject { Swow::Fields.new(fields, reference_fields) }
      it "return true" do
        expect(subject.valid?).to be true
      end
    end

    context "all fields are not contained in reference fields" do
      let(:fields) { [1, 3, 5] }
      let(:reference_fields) { [1, 2, 3] }
      subject { Swow::Fields.new(fields, reference_fields) }
      it "return true" do
        expect(subject.valid?).to be false
      end
    end
  end

  describe "validate!" do
    context "valid? is true" do
      subject { Swow::Fields.new([], []) }
      it "doesn't rase an error" do
        allow(subject).to receive(:valid?).and_return(true)
        expect { subject.validate! }.not_to raise_error
      end
    end

    context "valid? is false" do
      subject { Swow::Fields.new([], []) }
      it "doesn't rase an error" do
        allow(subject).to receive(:valid?).and_return(false)
        expect { subject.validate! }.to raise_error(/Invalid fields/)
      end
    end
  end
end
