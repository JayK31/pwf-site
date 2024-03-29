class Workshop < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :season
  has_many :workshop_enrollments
  has_many :aep_registrations, :through => :workshop_enrollments
  attr_accessible :name, :notes, :tutor_id 
  before_save :set_season
  default_scope order('name DESC')
  #delegate :name, :to => :tutor, :prefix => true
  scope :current, where(:season_id =>Season.current_season_id)

  def set_season
    self.season = Season.current
  end 
  def tutor_name
    tutor.try(:name) || "Pending"
  end
end
