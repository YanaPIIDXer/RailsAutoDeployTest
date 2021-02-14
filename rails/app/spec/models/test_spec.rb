require 'rails_helper'

RSpec.describe Test, type: :model do
  ```
  it "return_true method returns true" do
    test = Test.new()
    result = test.return_true()
    expect(result).to be_truthy
  end

  it "return_false method returns false" do
    test = Test.new()
    result = test.return_false()
    expect(result).to be_falsey
  end
  
  it "fail test" do
    test = Test.new()
    result = test.return_false()
    expect(result).to be_truthy
  end
  ```
end
