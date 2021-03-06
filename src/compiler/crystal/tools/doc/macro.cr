require "./item"

class Crystal::Doc::Macro
  include Item

  getter type
  getter :macro

  def initialize(@generator, @type, @macro)
  end

  def name
    @macro.name
  end

  def args
    @macro.args
  end

  def doc
    @macro.doc
  end

  def source_link
    @generator.source_link(@macro)
  end

  def anchor
    String.build do |io|
      CGI.escape(to_s, io)
      io << "-macro"
    end
  end

  def prefix
    ""
  end

  def abstract?
    false
  end

  def kind
    "macro "
  end

  def to_s(io)
    io << name
    args_to_s io
  end

  def args_to_s
    String.build { |io| args_to_s io }
  end

  def args_to_s(io)
    return if @macro.args.empty?

    io << '('
    @macro.args.each_with_index do |arg, i|
      io << ", " if i > 0
      io << '*' if @macro.splat_index == i
      io << arg
    end
    io << ')'
  end

  def args_to_html
    args_to_s
  end
end
