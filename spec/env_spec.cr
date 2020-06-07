require "spec"
require "../src/crank/env.cr"

describe Crank::Env do
  describe ".new" do
    it "parses the file for environment variables" do
      file = "#{Dir.current}/spec/fixtures/.env"
      puts file

      env = Crank::Env.new(file)

      entries = Hash(String, String).new
      env.entries do |key, value|
        entries[key] = value
      end

      entries["TEST"].should eq("test_value")
      entries["SINGLE_QUOTES"].should eq("are stripped")
      entries["DOUBLE_QUOTES"].should eq("are also stripped")
    end
  end
end