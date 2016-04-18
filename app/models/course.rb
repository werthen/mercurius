class Course < ActiveRecord::Base
  belongs_to :lecturer
  has_and_belongs_to_many :programmes, uniq: true
  has_many :faculties, -> { uniq }, through: :programmes
end
