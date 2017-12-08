require_relative '../../../spec_helper'

describe Web::Controllers::Authentication::Create do
  let(:action) { Web::Controllers::Authentication::Create.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
