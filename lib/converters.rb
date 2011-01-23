include Java

def load_required_gems
  jruby_home = "#{ENV['HOME']}/.rvm/gems/jruby-1.5.6@haml-sass-converters"

  $: << "#{jruby_home}/gems"

  $: << "#{jruby_home}/gems/haml-3.0.24/lib"
  $: << "#{jruby_home}/gems/hpricot-0.8.3-java/lib"
  $: << "#{jruby_home}/gems/abstract-1.0.0/lib"
  $: << "#{jruby_home}/gems/erubis-2.6.6/lib"
  $: << "#{jruby_home}/gems/sexp_processor-3.0.5/lib"
  $: << "#{jruby_home}/gems/ruby_parser-2.0.5/lib"
end

load_required_gems

require "haml"
require "haml/html"
require "sass/css"

require 'default_scripts_groups'
require 'editor_action_helper'
require 'action_group_helper'

class Converter
  def self.convert_selection editor
    if editor.has_selection?
      text = editor.selection
      s_start = editor.selection_start

      changed_text = yield(text)
      editor.replace_selection_text(changed_text)

      # restore selection
      editor.select(s_start, s_start + changed_text.length)

  #    # TODO: probably restore caret position
      #  editor.move_caret -3
    end
  end

  def self.convert_to_haml(html)
    Haml::HTML.new(html, :erb => true, :xhtml => true).render
  end

  def self.convert_to_sass(css)
    Sass::CSS.new(css).render(:sass)
  end

  def self.convert_to_scss(css)
    Sass::CSS.new(css).render(:scss)
  end
end

register_editor_action "html_to_haml",
                       :text => "Convert Html to Haml",
                       :description => "Converts Html content to Haml content.",
                       :group => "EditorPopupMenu",
                       :enable_in_modal_context => true do |editor, _|
  Converter.convert_selection editor do |text|
    Converter.convert_to_haml(text)
  end
end

register_editor_action "html_to_haml_erb",
                       :text => "Convert Html to Haml",
                       :description => "Converts Html content to Haml content.",
                       #:shortcut => "control shift PERIOD",
                       :group => "ScriptsErb",
                       :file_type => "RHTML" do |editor, _|
  Converter.convert_selection editor do |text|
    Converter.convert_to_haml(text)
  end
end

register_action_group "ScriptsCss", :text => "Css"

register_editor_action "css_to_sass",
                       :text => "Convert CSS to SASS",
                       :description => "Converts CSS content to SASS content.",
                       :group => "EditorPopupMenu",
                       :enable_in_modal_context => true do |editor, _|
  Converter.convert_selection editor do |text|
    Converter.convert_to_sass(text)
  end
end

register_editor_action "css_to_sass_css",
                       :text => "Convert CSS to SASS",
                       :description => "Converts CSS content to SASS content.",
                       #:shortcut => "control shift PERIOD",
                       :group => "ScriptsCss",
                       :file_type => "CSS" do |editor, _|
  Converter.convert_selection editor do |text|
    Converter.convert_to_sass(text)
  end
end
