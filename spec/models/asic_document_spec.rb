require "spec_helper"
require "json"
require "date"

describe Checkify::AsicDocument do
  let(:contents) do
    [
      Checkify::AsicDocumentContentsInner.new(sub_code: "X1", title: "Appointment"),
      Checkify::AsicDocumentContentsInner.new(sub_code: "X2", title: "Cessation")
    ]
  end
  let(:attributes) do
    {
      number: "484",
      date: Date.new(2024, 8, 15),
      code: "APPT",
      title: "Director appointment",
      pages: 5,
      contents: contents
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has number" do
      expect(instance.number).to eq("484")
    end

    it "has date" do
      expect(instance.date).to eq(Date.new(2024, 8, 15))
    end

    it "has code" do
      expect(instance.code).to eq("APPT")
    end

    it "has title" do
      expect(instance.title).to eq("Director appointment")
    end

    it "has pages" do
      expect(instance.pages).to eq(5)
    end

    it "has contents" do
      expect(instance.contents).to eq(contents)
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "number" => "484",
        "date" => "2024-08-15",
        "code" => "APPT",
        "title" => "Director appointment",
        "pages" => 5,
        "contents" => [
          { "subCode" => "X1", "title" => "Appointment" },
          { "subCode" => "X2", "title" => "Cessation" }
        ]
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.number).to eq("484")
      expect(obj.date).to eq(Date.new(2024, 8, 15))
      expect(obj.code).to eq("APPT")
      expect(obj.title).to eq("Director appointment")
      expect(obj.pages).to eq(5)
      expect(obj.contents.size).to eq(2)
      expect(obj.contents.map(&:sub_code)).to eq(["X1", "X2"])
      expect(obj.contents.map(&:title)).to eq(["Appointment", "Cessation"])
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
