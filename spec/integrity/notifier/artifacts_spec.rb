require File.dirname(__FILE__) + '/../../spec_helper'

describe Integrity::Notifier::Artifacts do
  include Integrity::Notifier::Test

  before(:each) do
    setup_database
  end

  def commit(state)
    Integrity::Build.gen(state)
  end

  it "does something when the build is successful" do
    notifier = Integrity::Notifier::Artifacts.new(commit(:successful), {})
    notifier.deliver!
    notifier.should be_published
  end

  it "does not do something when the build fails" do
    notifier = Integrity::Notifier::Artifacts.new(commit(:failed), {})
    notifier.deliver!
    notifier.should_not be_published
  end
end