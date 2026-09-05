require "spec_helper"
require "json"
require "date"

describe Checkify::EmailResponse do
  let(:format_obj) { Checkify::EmailResponseFormat.new(valid: true, account: "user", domain: "example.com") }
  let(:dns_obj) { Checkify::EmailResponseDns.new(valid: true) }

  let(:attributes) do
    {
      email: "user@example.com",
      valid: true,
      format: format_obj,
      dns: dns_obj,
      deliverable: true,
      can_connect_smtp: false,
      inbox_full: nil,
      disabled: nil,
      catch_all: nil,
      score: 0.85,
      free: false,
      disposable: nil,
      role: nil
    }
  end

  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has email" do
      expect(instance.email).to eq("user@example.com")
    end

    it "has valid" do
      expect(instance.valid).to eq(true)
    end

    it "has format" do
      expect(instance.format).to eq(format_obj)
    end

    it "has dns" do
      expect(instance.dns).to eq(dns_obj)
    end

    it "has deliverable" do
      expect(instance.deliverable).to eq(true)
    end

    it "has can_connect_smtp" do
      expect(instance.can_connect_smtp).to eq(false)
    end

    it "has inbox_full" do
      expect(instance.inbox_full).to be_nil
    end

    it "has disabled" do
      expect(instance.disabled).to be_nil
    end

    it "has catch_all" do
      expect(instance.catch_all).to be_nil
    end

    it "has score" do
      expect(instance.score).to eq(0.85)
    end

    it "has free" do
      expect(instance.free).to eq(false)
    end

    it "has disposable" do
      expect(instance.disposable).to be_nil
    end

    it "has role" do
      expect(instance.role).to be_nil
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "email" => "user@example.com",
        "valid" => true,
        "format" => { "valid" => true, "account" => "user", "domain" => "example.com" },
        "dns" => { "valid" => true },
        "deliverable" => true,
        "canConnectSmtp" => false,
        "inboxFull" => nil,
        "disabled" => nil,
        "catchAll" => nil,
        "score" => 0.85,
        "free" => false,
        "disposable" => nil,
        "role" => nil
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.email).to eq("user@example.com")
      expect(obj.valid).to eq(true)
      expect(obj.format).to be_a(Checkify::EmailResponseFormat)
      expect(obj.format.account).to eq("user")
      expect(obj.format.domain).to eq("example.com")
      expect(obj.dns).to be_a(Checkify::EmailResponseDns)
      expect(obj.dns.valid).to eq(true)
      expect(obj.deliverable).to eq(true)
      expect(obj.can_connect_smtp).to eq(false)
      expect(obj.inbox_full).to be_nil
      expect(obj.disabled).to be_nil
      expect(obj.catch_all).to be_nil
      expect(obj.score).to eq(0.85)
      expect(obj.free).to eq(false)
      expect(obj.disposable).to be_nil
      expect(obj.role).to be_nil
    end
  end
end
