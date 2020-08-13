require 'test_helper'

# bundle exec ruby -Itest test/controllers/static_pages_controller_test.rb
class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  it "returns custom error page for 404" do
    get "/404"
    assert_select "h1.title", "404"
  end

  it "returns custom error page for 500" do
    get "/500"
    assert_select "h1.title", "500"
  end
end
