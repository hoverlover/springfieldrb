require 'spec_helper'

describe Member do
  let(:member) { Factory.build :member }

  describe "#full_name" do
    context "when both the first_name and last_name have values" do
      before do
        member.first_name = 'John'
        member.last_name = 'Norum'
      end

      it "should concatenate the first_name and last_name fields separated by a space" do
        member.full_name.should == "#{member.first_name} #{member.last_name}"
      end
    end

    name_types = %w[first last]
    name_types.each_with_index do |name_type, i|
      context "when only the #{name_type}_name has a value" do
        before do
          # Populate the current name type and set the other to nil
          #
          member.send "#{name_type}_name=", Faker::Name.send("#{name_type}_name")
          member.send "#{name_types[i - 1]}_name=", nil
        end

        it "should return only the #{name_type}_name with no space at the end" do
          member.full_name.should == member.send("#{name_type}_name")
        end
      end
    end
  end
end
