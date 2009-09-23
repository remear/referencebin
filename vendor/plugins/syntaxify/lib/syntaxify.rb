module Syntaxify
  def syntaxify(table_column, opts={})

    define_method table_column do
      replaced_text = self.class.scan_for_codeblocks(self[table_column]) do |code_block, lang|
        CodeRay.scan(code_block, lang).div(opts)
      end
      replaced_text
    end

    define_method "#{table_column}_raw" do
      self[table_column]
    end

  end

  def scan_for_codeblocks(text, &blk)
    scanner = Text4CodeParser.new(text)
    res = scanner.parse(&blk)
    res.join
  end
end

ActiveRecord::Base.extend(Syntaxify)