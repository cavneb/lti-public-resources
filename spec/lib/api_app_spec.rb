require File.dirname(__FILE__) + '/../spec_helper'

describe LtiPublicResources::ApiApp do

  def app
    LtiPublicResources::ApiApp.new(nil, CONFIG_FILE)
  end

  it "GET /lti_apps" do
    get '/lti_apps'
    last_response.should be_ok

    data = JSON.parse(last_response.body)
    data['lti_apps'].length.should eq(5)
    data['lti_apps']['vimeo']['name'].should eq('Vimeo')
  end

  it "GET /lti_apps/:id" do
    get '/lti_apps/vimeo'
    last_response.should be_ok

    data = JSON.parse(last_response.body)
    data['lti_app']['name'].should eq('Vimeo')
  end

end