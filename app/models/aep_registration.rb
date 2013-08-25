class AepRegistration < ActiveRecord::Base
  belongs_to :student_registration
  has_one :student, :through => :student_registration
  attr_accessible :student_registration_id, :learning_disability, :learning_disability_details, :iep, :iep_details, :student_academic_contract, :parent_participation_agreement, :transcript_test_score_release
  delegate :name, :to => :student, :prefix => true
  validates :learning_disability_details, :presence => true, :if => :learning_disability?
  validates :iep_details, :presence => true, :if => :iep?
end
