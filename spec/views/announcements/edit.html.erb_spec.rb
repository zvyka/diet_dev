require 'spec_helper'

describe "announcements/edit.html.erb" do
  before(:each) do
    @announcement = assign(:announcement, stub_model(Announcement,
      :message => "MyText"
    ))
  end

  it "renders the edit announcement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => announcements_path(@announcement), :method => "post" do
      assert_select "textarea#announcement_message", :name => "announcement[message]"
    end
  end
end
