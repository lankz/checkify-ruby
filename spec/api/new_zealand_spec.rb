require "spec_helper"

describe "New Zealand addresses" do
  let(:api) { Checkify::AddressApi.new }

  it "looks up an NZ address with structured details", vcr: { cassette_name: "address/nz_address" } do
    results = api.autocomplete("1 queen street auckland", country: "nz")
    expect(results).not_to be_empty
    details = api.autocomplete_details(results.keys.first, country: "nz")
    expect(details.country).to eq("NZ")
    expect(details.region).to be_a(String)
    expect(details.state).to be_nil
    expect(details.street).to be_a(String)
  end

  it "preserves nullable NZ suburb fields", vcr: { cassette_name: "address/nz_suburb" } do
    results = api.autocomplete_suburb("auckland", country: "nz")
    expect(results).not_to be_empty
    details = api.autocomplete_suburb_details(results.keys.first, country: "nz")
    expect(details.country).to eq("NZ")
    expect(details.region).to be_a(String)
    expect(details.state).to be_nil
    expect(details.postcode).to be_nil
  end

  it "looks up an NZ postcode", vcr: { cassette_name: "address/nz_postcode" } do
    results = api.postcode_lookup("1010", country: "nz")
    expect(results).not_to be_empty
    expect(results.map(&:country).uniq).to eq(["NZ"])
    expect(results.map(&:postcode).uniq).to eq(["1010"])
  end

  it "reverse geocodes NZ coordinates", vcr: { cassette_name: "address/nz_reverse" } do
    results = api.reverse_geocode(-36.844, 174.766, country: "nz", radius: 500, limit: 2)
    expect(results.size).to be_between(1, 2)
    expect(results.first.distance_metres).to be_a(Numeric)
    expect(results.first.address_full).to be_a(String)
  end
end
