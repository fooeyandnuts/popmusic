require 'spec_helper'

describe SoundcloudsController do

	describe "GET new" do
		it "returns http success" do
			get 'new'
			expect(response).to be_success
		end
	end

	

end
