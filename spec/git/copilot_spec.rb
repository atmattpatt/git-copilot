# frozen_string_literal: true

RSpec.describe Git::Copilot do
  it "has a version number" do
    expect(Git::Copilot::VERSION).not_to be nil
  end
end
