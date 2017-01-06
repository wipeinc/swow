require "spec_helper"

describe Swow::ParamsEncoder do
  describe "encode" do
    context "params does not contain arrays" do
      let(:params) { {param1: "a", param2: "b"} }
      it "parse params" do
        expect(Swow::ParamsEncoder.encode(params)).to eq "param1=a&param2=b"
      end
    end
    context "params contain a field (Array)" do
      let(:params) { {param1: %w(a b c), param2: "z"} }
      it "parse fields params" do
        expect(Swow::ParamsEncoder.encode(params)).to eq "param1=a,b,c&param2=z"
      end
    end
  end
  describe "decode" do
    context "params buffer does not contain arrays" do
      let(:buffer) { "param1=a&param2=b" }
      it "decode params" do
        expect(Swow::ParamsEncoder.decode(buffer)).to eq({"param1" => "a", "param2" => "b"})
      end
    end
    context "params buffer contain arrays" do
      let(:buffer) { "param1=a,b,c&param2=z" }
      it "decode params" do
        expect(Swow::ParamsEncoder.decode(buffer)).to eq({"param1" => %w(a b c), "param2" => "z"} )
      end
    end
  end
end
