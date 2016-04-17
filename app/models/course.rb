class Course < ActiveRecord::Base
  belongs_to :lecturer
  has_and_belongs_to_many :programmes
  has_many :faculties, through: :programmes
end
