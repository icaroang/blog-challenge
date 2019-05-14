RSpec.shared_examples 'validates_presence_of' do |options|
  options.each do |attribute, value|
    describe "validates presence of #{attribute}" do
      
      context "when attribute is blank" do
        before { params[attribute] = '' }
        
        it "adds error" do
          expect(errors[attribute]).to include("can't be blank")
        end
      end

      context "when attribute isn't blank" do
        before { params[attribute] = value }

        it "doesn't add error" do
          expect(errors[attribute]).to_not include("can't be blank")
        end
      end
    end
  end
end
