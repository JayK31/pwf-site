require "spec_helper"

describe GradeRanger, :focus => :grades do

  describe ".range_for" do
    it "produces a continuous range from 0 to 4" do
      GradeRanger.range_for(:four_point).should == (0..4)
    end

    it "produces a discrete range from A+ to F" do
      GradeRanger.range_for(:a_plus_to_f).should == %w(A+ A- A B+ B B- C+ C C- D+ D D- F)
    end
  end

  describe ".description_for" do
    it "produces a description 4 point scale" do
      GradeRanger.description_for(:four_point).should == "Four Point"
    end

    it "produces a description for  A+ to F" do
      GradeRanger.description_for(:a_plus_to_f).should == "A Plus To F"
    end
  end

  describe ".for_select" do
    it "generates an array for select" do
      GradeRanger.for_select.should ==
      [["Four Point", 0],
       ["Hundred Point", 1],
       ["A To F", 2],
       ["A Plus To F", 3]]
    end
  end

  describe ".range_by_format_index" do

    it "produces a discrete range from A+ to F" do
      GradeRanger.range_by_format_index(0).should == (0..4)
    end
  end
end
