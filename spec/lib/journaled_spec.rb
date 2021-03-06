require 'rails_helper'

RSpec.describe Journaled do
  it "is enabled in production" do
    allow(Rails).to receive(:env).and_return("production")
    expect(Journaled).to be_enabled
  end

  it "is disabled in development" do
    allow(Rails).to receive(:env).and_return("development")
    expect(Journaled).not_to be_enabled
  end

  it "is disabled in test" do
    allow(Rails).to receive(:env).and_return("test")
    expect(Journaled).not_to be_enabled
  end

  it "is enabled in whatevs" do
    allow(Rails).to receive(:env).and_return("whatevs")
    expect(Journaled).to be_enabled
  end

  it "is enabled when explicitly enabled in development" do
    with_env(JOURNALED_ENABLED: true) do
      allow(Rails).to receive(:env).and_return("development")
      expect(Journaled).to be_enabled
    end
  end

  it "is disabled when explicitly disabled in production" do
    with_env(JOURNALED_ENABLED: false) do
      allow(Rails).to receive(:env).and_return("production")
      expect(Journaled).not_to be_enabled
    end
  end

  it "is disabled when explicitly disabled with empty string" do
    with_env(JOURNALED_ENABLED: '') do
      allow(Rails).to receive(:env).and_return("production")
      expect(Journaled).not_to be_enabled
    end
  end

  describe "#actor_uri" do
    it "delegates to ActorUriProvider" do
      allow(Journaled::ActorUriProvider).to receive(:instance).and_return(double(actor_uri: "my actor uri"))
      expect(Journaled.actor_uri).to eq "my actor uri"
    end
  end
end
