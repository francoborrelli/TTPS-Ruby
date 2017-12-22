module StudentHelper
  def score_status(student, exam)
    if student.took_exam?(exam)
      if student.score_for_exam(exam).passed?
        content_tag(:span, (t :passed), class: 'text-success')
      else
        content_tag(:span, (t :failed), class: 'text-danger')
      end
    else
      content_tag(:span, (t :absent), class: 'text-warning')
    end
  end
end
