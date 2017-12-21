module CourseHelper
  def time_range
    (min_year..max_year).to_a
    end

  def min_year
    Time.zone.today.year - 15
  end

  def max_year
    Time.zone.today.year + 5
  end

  def course_title(course)
    "#{(t :course).capitalize} #{course.year.to_s}"
  end
end
