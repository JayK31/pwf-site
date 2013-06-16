class StudentRegistration < ActiveRecord::Base
  belongs_to :season
  belongs_to :student
  belongs_to :payment
  has_many :attendances
  has_many :grades
  has_many :report_cards
  attr_accessible :school, :grade, :size_cd, :medical_notes, :academic_notes, :academic_assistance, :student_id, :season_id, :status_cd

  before_create :get_status
  validates :season, :school, :grade, :size_cd,  :presence => :true
  validates :student, :presence => true, :on => :save
  delegate :name, :dob, :gender, :age, :to => :student,:prefix => true

  SIZES = %w(Kids\ xs Kids\ S Kids\ M Kids\ L S M L XL 2XL 3XL)
  as_enum :size, SIZES.each_with_index.inject({}) {|h, (item,idx)| h[item]=idx; h}

  as_enum :status, ["Pending", "Confirmed Fee Waived", "Confirmed Paid", "Wait List", "Withdrawn" ]

  def self.unpaid
    where(["status_cd = ?", statuses["Pending"]])
  end

  def self.paid
    where(["status_cd = ?", statuses["Confirmed Paid"]])
  end

  def self.enrolled
    where("status_cd in (#{statuses['Confirmed Fee Waived']}, #{statuses['Confirmed Paid']})" )
  end

  def self.wait_listed
    where(:status_cd => statuses["Wait List"] )
  end
 
  def self.current_wait_listed
    current.wait_listed
  end

  def self.current_wait_listed_count
   current_wait_listed.count
  end

  def self.wait_listed_count
   wait_listed.count
  end

  def self.current
    where(:season_id => Season.current_season_id)
  end

  def self.previous_season
    where(:season_id => Season.previous_season_id)
  end

  def self.current_count
    current.count
  end

  def self.inactive
    where("season_id != ?",Season.current.id)
  end
  def paid?
    !payment_id.nil?
  end
  def season_description
    season.description
  end

  def active?
    season.is_current?
  end

  def student_name
    student.name
  end

  def unconfirmed?
    self.class.statuses.except("Confirmed Fee Waived","Confirmed Paid").include? status
  end

  def confirmed
    !unconfirmed?
  end

  def mark_as_paid(payment)
    self.payment = payment
    self.status = "Confirmed Paid"
    save!
  end



  private
  def get_status
    if Season.current && Season.current.status == "Wait List"
      self.status = "Wait List"
    else
      self.status = "Pending"
    end
  end

end
