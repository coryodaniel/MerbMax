require File.dirname(__FILE__) + '/spec_helper'

describe "merb_meta" do
  class Application < Merb::Controller
    meta :title     => 'My default title', 
      :description  => 'An awesome description',
      :keywords     => 'awesome, test, controller'
  end
  
  class DefaultPerController < Application
    meta :title     => 'Woo, the Internet!!!',
      :description  => "its a fun place to make fun of people and find pr0n",
      :keywords     => "fun,place,people,pr0n"
  end
  
  class OverrideSomeController < Application
    meta :title     => "This is different, Arbys is different"
  end
  
  class OverridePerActionController < Application
    meta :title     => 'Override this plz.'
    def index
      meta :keywords => "something fantastic"
    end
  end
  
  it "should be able to have default meta information for all controllers" do
    Application.meta.class.should be(Hash)
    Application.meta(:title).should == 'My default title'
  end
  
  it "should be able to have default meta information for a controller" do
    Application.meta(:keywords).should == 'awesome, test, controller'
    DefaultPerController.meta(:keywords).should == "fun,place,people,pr0n"  
    default_per_controller = DefaultPerController.new fake_request
    default_per_controller.meta(:keywords).should == "fun,place,people,pr0n"
  end
  
  it 'should be able to override meta info on a tag-by-tag basis' do
    Application.meta(:title).should == 'My default title'
    OverrideSomeController.meta(:title).should == "This is different, Arbys is different"
    #OverrideSomeController.meta(:keywords).should == Application.meta(:keywords)
    
    override_some = OverrideSomeController.new fake_request
    override_some.meta(:title).should == OverrideSomeController.meta(:title)
    override_some.meta :keywords => "super, awesome, keywords"
    override_some.meta(:keywords).should_not == OverrideSomeController.meta(:keywords)
  end
  
  it 'should default meta tags to that of the parent class' do
    Application.meta(:keywords).should == 'awesome, test, controller'
    OverrideSomeController.meta(:keywords).should == Application.meta(:keywords)
  end

  it "should be able to have meta information on an action-by-action basis" do
    override_per_action = OverridePerActionController.new fake_request
    override_per_action.index
    override_per_action.meta(:keywords).should == "something fantastic"
  end
  
  it "should be able to output all meta data as HTML" do    
    override_some_meta_html     = OverrideSomeController.new(fake_request).meta
    index_not_called_meta_html  = OverridePerActionController.new(fake_request).meta

    opa_controller = OverridePerActionController.new fake_request
    opa_controller.index
    index_called_meta_html = opa_controller.meta
    
    override_some_meta_html.class.should be(String)
    index_not_called_meta_html.class.should be(String)
    index_called_meta_html.class.should be(String)

    override_some_meta_html.should    == %{<title>This is different, Arbys is different</title><meta name="description" content="An awesome description" /><meta name="keywords" content="awesome, test, controller" />}
    index_not_called_meta_html.should == %{<title>Override this plz.</title><meta name="description" content="An awesome description" /><meta name="keywords" content="awesome, test, controller" />}
    index_called_meta_html.should     == %{<title>Override this plz.</title><meta name="description" content="An awesome description" /><meta name="keywords" content="something fantastic" />}
  end
  
  it "should be able to retrieve meta data for a specific tag" do
    DefaultPerController.meta(:keywords).class.should be(String)
    DefaultPerController.meta(:title).class.should be(String)
    DefaultPerController.meta(:description).class.should be(String)
    
    DefaultPerController.meta(:title).should        == 'Woo, the Internet!!!'
    DefaultPerController.meta(:description).should  == "its a fun place to make fun of people and find pr0n"
    DefaultPerController.meta(:keywords).should     == "fun,place,people,pr0n"
  end
end