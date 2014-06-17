require "action_view"
require 'test/unit'
require_relative '../lib/negative_captcha'

class FormBuilderTest < Test::Unit::TestCase

  class Model
    attr_accessor :name
    attr_reader :errors

    def initialize
      @errors = {}
    end
  end

  def setup
    @model = Model.new
    @builder = ActionView::Helpers::FormBuilder.new(:model, @model, ActionView::Base.new, {})
    @captcha = NegativeCaptcha.new({fields: %i[name]})
  end

  def test_form_builder_does_not_surround_with_error_span_by_default
    refute_includes @builder.negative_text_field(@captcha, :name), "field_with_errors"
  end

  def test_form_builder_surrounds_with_error_span_on_error
    @model.errors[:name] = "some error"
    assert_includes @builder.negative_text_field(@captcha, :name), "field_with_errors"
  end

  def test_form_builder_uses_rails_error_span
    old_proc = ActionView::Base.field_error_proc
    ActionView::Base.field_error_proc = proc do |inner_html, instance|
      "<span class='alternative_errors'>".html_safe << inner_html << "</span>".html_safe
    end
    @model.errors[:name] = "some error"
    assert_includes @builder.negative_text_field(@captcha, :name), "alternative_errors"
  ensure
    ActionView::Base.field_error_proc = old_proc
  end

end
