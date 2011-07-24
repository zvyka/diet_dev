require 'spec_helper'

describe "announcements/index.html.erb" do
  before(:each) do
    assign(:announcements, [
      stub_model(Announcement,
        :message => "MyText"
      ),
      stub_model(Announcement,
        :message => "MyText"
      )
    ])
  end

  it "renders a list of announcements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
