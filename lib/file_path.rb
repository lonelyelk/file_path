# Class FilePath is used for comfortable work with file paths.
#
# Following File class methods are implemented:
#   filepath.blockdev?        => File.blockdev?(filepath)
#   filepath.chardev?         => File.chardev?(filepath)
#   filepath.directory?       => File.directory?(filepath)
#   filepath.executable?      => File.executable?(filepath)
#   filepath.executable_real? => File.executable_real?(filepath)
#   filepath.exist?           => File.exist?(filepath)
#   filepath.file?            => File.file?(filepath)
#   filepath.grpowned?        => File.grpowned?(filepath)
#   filepath.owned?           => File.owned?(filepath)
#   filepath.pipe?            => File.pipe?(filepath)
#   filepath.readable?        => File.readable?(filepath)
#   filepath.readable_real?   => File.readable_real?(filepath)
#   filepath.setgid?          => File.setgid?(filepath)
#   filepath.setuid?          => File.setuid?(filepath)
#   filepath.size?            => File.size?(filepath)
#   filepath.socket?          => File.socket?(filepath)
#   filepath.sticky?          => File.sticky?(filepath)
#   filepath.symlink?         => File.symlink?(filepath)
#   filepath.writable?        => File.writable?(filepath)
#   filepath.writable_real?   => File.writable_real?(filepath)
#   filepath.zero?            => File.zero?(filepath)
class FilePath < String
  # Creates new file path. If <code>path</code> param is not given, dirname of
  # current file is used
  def initialize(path = nil)
    if path
      replace expand(path)
    else
      replace expand(File.dirname(caller(1)[0].split(":")[0]))
    end
  end

  # Joins string or filepath into new path
  # Example:
  #   FilePath.new("/somedir")/"other_dir"/"file"     => "/somedir/other_dir/file"
  def /(other)
    self.class.new(expand(File.join(self, other)))
  end

  # Returns <code>true</code> if file path is a wildcard
  def wildcard?
    include?("*") || include?("?")
  end

  # Returns list of paths selected by wildcard or an array with one specified file
  # if it exists
  def list
    Dir.glob(self).map{ |p| self.class.new(p)}
  end

  # Returns <code>true</code> if wildcard selection includes specified path
  def include_path?(filepath)
    list.include?(expand(filepath))
  end

  # Returns file path as in File.dirname but of FilePath type
  def dirname
    self.class.new(File.dirname(self))
  end

  # Returns string with basename like in File.basename
  def basename(suffix = "")
    File.basename(self, suffix)
  end

  [:blockdev?, :chardev?, :directory?, :executable?, :executable_real?, :exist?,
    :file?, :grpowned?, :owned?, :pipe?, :readable?, :readable_real?, :setgid?,
    :setuid?, :size?, :socket?, :sticky?, :symlink?, :writable?, :writable_real?,
    :zero?].each do |mthd|
      class_eval <<-RUBY
        def #{mthd}
          File.#{mthd}(self)
        end
      RUBY
    end

  class << self
    # Path to current file: File.expand_path(__FILE__)
    def current
      new(caller(1)[0].split(":")[0])
    end
  end

protected

  def expand(path)
    File.expand_path(path)
  end
end
