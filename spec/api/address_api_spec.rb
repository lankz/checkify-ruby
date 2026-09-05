require "spec_helper"
require "json"

describe Checkify::AddressApi do
  let(:api) { described_class.new }

  describe "#autocomplete", vcr: { cassette_name: "address/autocomplete" } do
    it "returns a hash of address IDs to highlighted strings" do
      result = api.autocomplete("1 macquarie st sydney")
      expect(result).to be_a(Hash)
      expect(result.size).to be > 0
      result.each do |id, label|
        expect(id.to_s).to be_a(String)
        expect(label).to be_a(String)
      end
    end

    it "raises when query is too short" do
      expect { api.autocomplete("ab") }.to raise_error(ArgumentError, /character length/)
    end

    it "raises when query is nil" do
      expect { api.autocomplete(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end

    it "raises for invalid country" do
      expect { api.autocomplete("1 macquarie st", country: "xx") }.to raise_error(ArgumentError, /must be one of/)
    end
  end

  describe "#autocomplete_details", vcr: { cassette_name: "address/autocomplete_details" } do
    let(:address_id) do
      VCR.use_cassette("address/autocomplete_for_details") do
        api.autocomplete("1 macquarie st sydney").keys.first
      end
    end

    it "returns an AddressDetails object with structured fields" do
      result = api.autocomplete_details(address_id)
      expect(result).to be_a(Checkify::AddressDetails)
      expect(result.street_number).to be_a(String)
      expect(result.street_name).to be_a(String)
      expect(result.street).to be_a(String)
      expect(result.city).to be_a(String)
      expect(result.postcode).to eq("2000")
      expect(result.country).to eq("AU")
    end

    it "includes coordinates" do
      result = api.autocomplete_details(address_id)
      expect(result.latitude).to be_a(Numeric)
      expect(result.longitude).to be_a(Numeric)
    end

    it "raises when id is nil" do
      expect { api.autocomplete_details(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  describe "#autocomplete_suburb", vcr: { cassette_name: "address/autocomplete_suburb" } do
    it "returns a hash of locality IDs to highlighted strings" do
      result = api.autocomplete_suburb("sydney")
      expect(result).to be_a(Hash)
      expect(result.size).to be > 0
    end

    it "raises when query is too short" do
      expect { api.autocomplete_suburb("s") }.to raise_error(ArgumentError, /character length/)
    end
  end

  describe "#autocomplete_suburb_details", vcr: { cassette_name: "address/autocomplete_suburb_details" } do
    let(:locality_id) do
      VCR.use_cassette("address/autocomplete_suburb_for_details") do
        api.autocomplete_suburb("sydney").keys.first
      end
    end

    it "returns a SuburbDetails object" do
      result = api.autocomplete_suburb_details(locality_id)
      expect(result).to be_a(Checkify::SuburbDetails)
      expect(result.city).to be_a(String)
      expect(result.postcode).to be_a(String)
      expect(result.state).to be_a(String)
      expect(result.country).to eq("AU")
    end

    it "raises when id is nil" do
      expect { api.autocomplete_suburb_details(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  describe "#postcode_lookup", vcr: { cassette_name: "address/postcode_lookup" } do
    it "returns an array of PostcodeResult objects for Sydney postcode" do
      results = api.postcode_lookup("2000")
      expect(results).to be_an(Array)
      expect(results.size).to be > 0
      results.each do |r|
        expect(r).to be_a(Checkify::PostcodeResult)
        expect(r.city).to be_a(String)
        expect(r.postcode).to eq("2000")
      end
    end

    it "raises for invalid postcode format" do
      expect { api.postcode_lookup("abc") }.to raise_error(ArgumentError, /must conform to the pattern/)
    end

    it "raises when postcode is nil" do
      expect { api.postcode_lookup(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  # 1 Macquarie St, Sydney coordinates
  describe "#reverse_geocode", vcr: { cassette_name: "address/reverse_geocode" } do
    let(:lat) { -33.8688 }
    let(:lng) { 151.2130 }

    it "returns an array of ReverseResult objects near Sydney" do
      results = api.reverse_geocode(lat, lng, radius: 200)
      expect(results).to be_an(Array)
      expect(results.size).to be > 0

      result = results.first
      expect(result).to be_a(Checkify::ReverseResult)
      expect(result.address_full).to be_a(String)
      expect(result.latitude).to be_a(Numeric)
      expect(result.longitude).to be_a(Numeric)
      expect(result.distance_metres).to be_a(Numeric)
    end

    it "raises when lat is nil" do
      expect { api.reverse_geocode(nil, lng) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end

    it "raises when lng is nil" do
      expect { api.reverse_geocode(lat, nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end

    it "raises when radius is out of range" do
      expect { api.reverse_geocode(lat, lng, radius: 6000) }.to raise_error(ArgumentError, /must be smaller than or equal to/)
      expect { api.reverse_geocode(lat, lng, radius: 0) }.to raise_error(ArgumentError, /must be greater than or equal to/)
    end

    it "raises when limit is out of range" do
      expect { api.reverse_geocode(lat, lng, limit: 11) }.to raise_error(ArgumentError, /must be smaller than or equal to/)
    end
  end
end
