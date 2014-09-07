require 'rails_helper'


describe Color do
  it "errors for invalid shades" do
    expect {Color.new(red:300)  }.to raise_error(Color::InvalidColorShade)
  end

  it "compares two identical colors as equal" do
    expect(Color.new(green:50)).to eq(Color.new(green:50))
  end

end