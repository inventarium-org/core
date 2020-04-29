# frozen_string_literal: true

require 'kramdown'
require 'rouge'
require 'rinku'

module Libs
  class MarkdownParser
    CHECKBOX_REGEXP_CHECKED = /\K\[(x|X)\]\s?(.*)</.freeze
    CHECKBOX_REGEXP_UNCHECKED = /\K\[ \]\s?(.*)</.freeze

    def initialize(kramdown = ::Kramdown::Document)
      @kramdown = kramdown
    end

    def call(text)
      Rinku.auto_link parse_checkbox parse text
    end

    private

    def parse(text)
      @kramdown.new(text, input: 'GFM', coderay_csscoderay_css: :class, syntax_highlighter: :rouge).to_html
    end

    def parse_checkbox(html)
      html
        .gsub(CHECKBOX_REGEXP_CHECKED, %(<input type="checkbox" checked disabled><label>\\2</label><))
        .gsub(CHECKBOX_REGEXP_UNCHECKED, %(<input type="checkbox" disabled><label>\\1</label><))
    end
  end
end
