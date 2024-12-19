require './spec/spec_helper'

RSpec.describe do
    before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
    end

    it 'can initialize' do
        expect(@cruiser).to be_an_instance_of(Ship)
        expect(@cruiser.name).to eq("Cruiser")
        expect(@cruiser.length).to eq(3)
    end

end