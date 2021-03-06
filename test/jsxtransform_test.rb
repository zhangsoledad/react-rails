require 'test_helper'

# The transformer is inserting a newline after the docblock for some reason...
EXPECTED_JS = <<eos
React.createElement("div", null);
eos

EXPECTED_JS_2 = <<eos
(function() {
  var Component;

  Component = React.createClass({displayName: "Component",
    render: function() {
      return React.createElement(ExampleComponent, {videos:this.props.videos} );
    }
  });

}).call(this);
eos

class JSXTransformTest < ActionDispatch::IntegrationTest

  test 'asset pipeline should transform JSX' do
    get '/assets/example.js'
    assert_response :success
    assert_equal EXPECTED_JS, @response.body
  end

  test 'asset pipeline should transform JSX + Coffeescript' do
    get '/assets/example2.js'
    assert_response :success
    # Different coffee-script may generate slightly different outputs,
    # as some version inserts an extra "\n" at the beginning.
    # Because appraisal is used, multiple versions of coffee-script are treated
    # together. Remove all spaces to make test pass.
    assert_equal EXPECTED_JS_2.gsub(/\s/, ''), @response.body.gsub(/\s/, '')
  end

end
