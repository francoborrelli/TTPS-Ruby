User.create(username: 'admin', password: '123456')

Course.create year: Time.zone.today.year
Course.create year: (Time.zone.today.year - 1)

14.times do |i|
  course = Course.all.sample
  name = Faker::HarryPotter.character.split(/\W+/)
  email = "#{name.first}@#{name.last}.com"
  Student.create(name: name.first, surname: name.last,
                 course: course, dni: (39_831_178 + i).to_s,
                 email: email, s_number: "137#{i}/#{i % 10}")
end

Course.all.each do |course|
  4.times do |i|
    title = "Test #{i}"
    score = rand(0..100)
    date = Time.zone.today.change(year: course.year) + i.days
    Examination.create(course: course, title: title,
                       min_score: score, date: date)
  end
end

Examination.all.each do |exam|
  students = exam.course.students.shuffle.first(4) 
    students.each do |student| 
    score = rand(0..100.0).round(2)
    exam.scores.build(score: score, student: student)
    exam.save
  end
end
