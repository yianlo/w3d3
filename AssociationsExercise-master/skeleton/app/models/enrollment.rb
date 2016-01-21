# == Schema Information
#
# Table name: enrollments
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  student_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Enrollment < ActiveRecord::Base
  belongs_to :student,
    foreign_key: :student_id,
    primary_key: :id,
    class_name: 'User'

  belongs_to :course,
    foreign_key: :course_id,
    primary_key: :id,
    class_name: 'Course'

end
