require "spec_helper"
require "tmpdir"
require "fileutils"
require "open3"

describe "Gem packaging" do
  it "excludes credentials, recordings, and incidental files even when they exist" do
    root = File.expand_path("..", __dir__)
    Dir.mktmpdir do |directory|
      FileUtils.cp(File.join(root, "checkify.gemspec"), directory)
      FileUtils.cp_r(File.join(root, "lib"), directory)
      %w[.env spec/fixtures/cassettes/account.yml specs_to_complete.md pkg/old.gem lib/nested/.env].each do |file|
        path = File.join(directory, file)
        FileUtils.mkdir_p(File.dirname(path))
        File.write(path, "private local data")
      end
      output, status = Bundler.with_unbundled_env do
        Open3.capture2(RbConfig.ruby, "-rjson", "-e",
                      'puts JSON.generate(Gem::Specification.load("checkify.gemspec").files)', chdir: directory)
      end
      expect(status.success?).to be(true)
      files = JSON.parse(output)
      expect(files.grep(/\.env|cassettes|specs_to_complete|old\.gem/)).to be_empty
      expect(files).to include("LICENSE", "README.md", "lib/checkify.rb", "lib/checkify/client.rb")
    end
  end
end
