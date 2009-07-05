class FilePath < String
  def initialize(path)
    replace expand(path)
  end
  def /(other)
    FilePath.new(expand(File.join(self, other)))
  end
  class << self
    def current
      self.new(File.dirname(caller(1)[0].split(":")[0]))
    end
  end
protected
  def expand(path)
    File.expand_path(path)
  end
end
