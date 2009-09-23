module Syntaxify
  class Text4CodeParser
    def initialize(text)
      @scanner = StringScanner.new(text)
      @beginning_regexp = /\[code=(["']?)([a-z]+)\1\]/
      @end_regexp = /\[\/code\]/
      @pointer = 0
    end

    def parse &blk
      text = []
      while @scanner.exist? @beginning_regexp
        text << get_text()
        lang = get_lang()
        text <<  blk.call(get_code(), lang)
      end
      text << get_text()
      text
    end

    def get_text()
      if @scanner.exist? @beginning_regexp
        @scanner.check_until(@beginning_regexp)[0...-@scanner.matched_size]
      else
        @scanner.scan_until(/.*/m)
      end
    end

    def get_lang()
      @scanner.scan_until(@beginning_regexp)
      lang = @scanner.matched.match(@beginning_regexp)[2]
      @pointer = @scanner.pos
      lang
    end

    def get_code()
      @scanner.scan_until(@end_regexp)
      self_size = @scanner.matched_size
      code = @scanner.pre_match[@pointer..@scanner.pos-self_size]
      code
    end
  end
end