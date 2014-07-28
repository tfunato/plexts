require 'spec_helper'

describe GetPrexts do
  it 'should have a version number' do
    GetPrexts::VERSION.should_not be_nil
  end

  GetPrexts.getPrexts
  #p GetPrexts.headers
end
