require File.join(File.dirname(__FILE__), "..", "lib", "file_path.rb")

describe FilePath do
  it "should show correct current path" do
    FilePath.current.should == File.expand_path(__FILE__)
  end

  it "should show correct current dirname path when initialized" do
    FilePath.new.should == File.expand_path(File.dirname(__FILE__))
  end
  
  it "should call File class methods on path which return boolean" do
    FilePath.new.directory?.should == true
    FilePath.current.file?.should == true
    FilePath.new("/some/dir").exist?.should == false
    # Should I really be testing it?
  end
  
  it "should recognize wildcard" do
    (FilePath.new/"**"/"*.rb").wildcard?.should == true
    (FilePath.new/"s?mefile.??").wildcard?.should == true
    FilePath.current.wildcard?.should == false
  end
end
