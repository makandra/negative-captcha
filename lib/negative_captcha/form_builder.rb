module ActionView
  module Helpers
    class FormBuilder
      def negative_text_field(captcha, method, options = {})
        html = @template.negative_text_field_tag(
          captcha,
          method,
          options
        ).html_safe

        _surround_with_error(html, method)
      end

      def negative_text_area(captcha, method, options = {})
        html = @template.negative_text_area_tag(
          captcha,
          method,
          options
        ).html_safe

        _surround_with_error(html, method)
      end

      def negative_hidden_field(captcha, method, options = {})
        @template.negative_hidden_field_tag(captcha, method, options).html_safe
      end

      def negative_file_field(captcha, method, options = {})
        html = @template.negative_file_field_tag(
          captcha,
          method,
          options
        ).html_safe

        _surround_with_error(html, method)
      end

      def negative_check_box_field(captcha, method, options = {})
        html = @template.negative_check_box_tag(
          captcha,
          method,
          options
        ).html_safe

        _surround_with_error(html, method)
      end

      def negative_password_field(captcha, method, options = {})
        html = @template.negative_password_field_tag(
          captcha,
          method,
          options
        ).html_safe

        _surround_with_error(html, method)
      end

      def negative_label(captcha, method, name, options = {})
        html = @template.negative_label_tag(
          captcha,
          method,
          name,
          options
        ).html_safe

        _surround_with_error(html, method)
      end

      private

      def _surround_with_error(html, method)
        if object.errors[method].present?
          ActionView::Base.field_error_proc.call(html, self)
        else
          html
        end
      end

    end
  end
end
