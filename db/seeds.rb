User.create(username: 'admin', password: '123456', email: 'admin@admin.com')

Course.create year: Date.today.year 
Course.create year: (Date.today.year - 1)

(0..7).each do |i|
  offset = rand(Course.count)
  course = Course.offset(offset).first
  name = Faker::HarryPotter.character.split(/\W+/)
  email = name.first + '@' + name.last + '.com'
  Student.create(name: name.first, surname: name.last, course: course, dni: (39_831_178 + i).to_s, email: email, s_number: ('123123/3' + i.to_s))
end

Course.all.each do |course|
  for i in 0..4
    title = Faker::GameOfThrones.quote.truncate(33)
    date = Date.today.change(year: course.year) + i.days
    score = rand (0..100)
    Examination.create(course: course, title: title, min_score: score, date: date)
  end
end

Examination.all.each do |exam|
  for i in 0..4
    offset = rand(exam.course.students.count)
    student = exam.course.students.offset(offset).first
    score = rand (0..100)
    Score.create(student: student, examination: exam, score: score)
  end
end
