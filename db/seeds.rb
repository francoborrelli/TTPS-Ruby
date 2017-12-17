User.create(username: 'admin', password: '123456', email: 'admin@admin.com')

Course.create year: Time.zone.today.year
Course.create year: (Time.zone.today.year - 1)

15.times do |i|
  offset = rand(Course.count)
  course = Course.offset(offset).first
  name = Faker::HarryPotter.character.split(/\W+/)
  email = name.first + '@' + name.last + '.com'
  Student.create(name: name.first, surname: name.last, course: course, dni: "#{39_831_178 + i}", email: email, s_number: ("137#{i}/#{i/10}"))
end

Course.all.each do |course|
  4.times do |i|
    title = "Test #{i}"
    date = Time.zone.today.change(year: course.year) + i.days
    score = rand(0..100)
    Examination.create(course: course, title: title, min_score: score, date: date)
  end
end

Examination.all.each do |exam|
  6.times do
    offset = rand(exam.students.count)
    student = exam.students.offset(offset).first
    score = rand(0..100.0).round(2)
    Score.create(student: student, examination: exam, score: score)
  end
end
