require "spec_helper"
require "json"

describe Checkify::IdentityApi do
  let(:api) { described_class.new }

  describe "#sanctions_screening" do
    context "with a matching name", vcr: { cassette_name: "identity/sanctions_screening_match" } do
      it "returns a match with results" do
        result = api.sanctions_screening("Mohammad Hassan", birth_year: 1950, country: "AF")
        expect(result).to be_a(Checkify::SanctionsResponse)
        expect(result.match).to be(true)
        expect(result.results).to be_an(Array)
        expect(result.results.size).to be > 0
      end

      it "includes sanctions details on each result" do
        result = api.sanctions_screening("Mohammad Hassan", birth_year: 1950, country: "AF")
        entry = result.results.first
        expect(entry).to be_a(Checkify::SanctionsResult)
        expect(entry.name).to be_a(String)
        expect(entry.type).to be_a(String)
        expect(entry.confidence).to be_a(Numeric)
        expect(entry.confidence).to be_between(0, 1)
        expect(entry.sanctions).to be_a(Checkify::SanctionsResultSanctions)
      end
    end

    context "with a non-matching name", vcr: { cassette_name: "identity/sanctions_screening_no_match" } do
      it "returns no match" do
        result = api.sanctions_screening("John Smith Test")
        expect(result).to be_a(Checkify::SanctionsResponse)
        expect(result.match).to be(false)
        expect(result.results).to be_an(Array)
        expect(result.results).to be_empty
      end
    end

    it "raises when name is nil" do
      expect { api.sanctions_screening(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end

    it "raises when name is too short" do
      expect { api.sanctions_screening("ab") }.to raise_error(ArgumentError, /character length/)
    end
  end

  describe "#director_id_validation", vcr: { cassette_name: "identity/director_id_validation" } do
    it "returns a valid DirectorIdResponse" do
      result = api.director_id_validation("036123456789010")
      expect(result).to be_a(Checkify::DirectorIdResponse)
      expect(result.valid).to be(true)
      expect(result.director_id).to eq("036123456789010")
      expect(result.director_id_formatted).to be_a(String)
      expect(result.notice).to be_a(String)
    end

    it "raises when director_id is nil" do
      expect { api.director_id_validation(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  describe "#tfn_validation", vcr: { cassette_name: "identity/tfn_validation" } do
    it "returns a valid TfnResponse" do
      result = api.tfn_validation("123456782")
      expect(result).to be_a(Checkify::TfnResponse)
      expect(result.valid).to be(true)
      expect(result.tfn).to eq("123456782")
      expect(result.tfn_formatted).to eq("123 456 782")
      expect(result.notice).to be_a(String)
    end

    it "raises when tfn is nil" do
      expect { api.tfn_validation(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end
end
