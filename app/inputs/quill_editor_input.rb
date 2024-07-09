# app/inputs/quill_editor_input.rb
class QuillEditorInput < Formtastic::Inputs::TextInput
    def input_html_options
      super.merge(class: 'quill-editor-class') # Add any additional classes or attributes here
    end
  
    def to_html
      input_wrapping do
        label_html <<
          builder.text_area(method, input_html_options)
      end
    end
  end
  