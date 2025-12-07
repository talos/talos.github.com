require 'rouge'
require 'fileutils'
require 'digest/md5'

ROUGE_CACHE_DIR = File.expand_path('../../.pygments-cache', __FILE__)
FileUtils.mkdir_p(ROUGE_CACHE_DIR)

module HighlightCode
  def highlight(str, lang)
    lang = 'ruby' if lang == 'ru'
    lang = 'objc' if lang == 'm'
    lang = 'perl' if lang == 'pl'
    lang = 'yaml' if lang == 'yml'
    str = rouge_highlight(str, lang).match(/<pre>(.+)<\/pre>/m)[1].to_s.gsub(/ *$/, '') #strip out divs <div class="highlight">
    tableize_code(str, lang)
  end

  def rouge_highlight(code, lang)
    if defined?(ROUGE_CACHE_DIR)
      path = File.join(ROUGE_CACHE_DIR, "#{lang}-#{Digest::MD5.hexdigest(code)}.html")
      if File.exist?(path)
        highlighted_code = File.read(path)
      else
        begin
          formatter = Rouge::Formatters::HTML.new
          lexer = Rouge::Lexer.find_fancy(lang, code) || Rouge::Lexers::PlainText
          highlighted_code = "<pre>" + formatter.format(lexer.lex(code)) + "</pre>"
        rescue => e
          raise "Rouge can't parse unknown language: #{lang}. Error: #{e.message}"
        end
        File.open(path, 'w') {|f| f.print(highlighted_code) }
      end
    else
      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexer.find_fancy(lang, code) || Rouge::Lexers::PlainText
      highlighted_code = "<pre>" + formatter.format(lexer.lex(code)) + "</pre>"
    end
    highlighted_code
  end
  def tableize_code (str, lang = '')
    table = '<div class="highlight"><table><tr><td class="gutter"><pre class="line-numbers">'
    code = ''
    str.lines.each_with_index do |line,index|
      table += "<span class='line-number'>#{index+1}</span>\n"
      code  += "<span class='line'>#{line}</span>"
    end
    table += "</pre></td><td class='code'><pre><code class='#{lang}'>#{code}</code></pre></td></tr></table></div>"
  end
end
