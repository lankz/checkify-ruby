require "spec_helper"
require "json"
require "date"

describe Checkify::BulkCreateRequestItems do
  describe "module shape" do
    it "defines a oneOf list" do
      expect(described_class.openapi_one_of).to include(:"Array<Object>", :"Array<String>")
    end
  end

  describe ".build" do
    it "accepts an array of strings" do
      expect(described_class.build(["a", "b"])).to eq(["a", "b"])
    end
  end
end
