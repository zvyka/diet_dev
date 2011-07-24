require 'spec_helper'

describe "announcements/new.html.erb" do
  before(:each) do
    assign(:announcement, stub_model(Announcement,
      :message => "MyText"
    ).as_new_record)
  end

  it "renders new announcement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => announcements_path, :method => "post" do
      assert_select "textarea#announcement_message", :name => "announcement[message]"
    end
  end
end
