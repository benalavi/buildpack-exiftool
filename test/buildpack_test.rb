unless ENV["HEROKU_API_KEY"]
  warn "Set HEROKU_API_KEY to your heroku API key (heroku auth:token) (https://github.com/heroku/hatchet)"
  exit 10
end

require "minitest/autorun"
require "hatchet"

class BuildpackTest < MiniTest::Unit::TestCase
  def test_package_is_installed
    Hatchet::Runner.new("app").deploy do |app|
      assert_match /9.40/, app.run("exiftool -ver")
      # Just chose a tag at random to show it can read the lib dir, also it
      # seems like something truncates the run output, so have to choose one
      # that appears before the truncation
      assert_match /CMWhiteBalanceComp/, app.run("exiftool -list")
    end
  end
end
