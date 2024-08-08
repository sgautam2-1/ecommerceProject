# app/inputs/quill_editor_input.rb
module ActiveAdmin
  module Inputs
    class QuillEditorInput < ::Formtastic::Inputs::TextInput
      def to_html
        input_wrapping do
          label_html <<
            builder.text_area(method, input_html_options)
        end
      end
    end
  end
end
