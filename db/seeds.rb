User.create({:username => "admin", :password => "123456", :email => "admin@admin.com"})

Course.create(:year => (Date.today.year ));
Course.create(:year => (Date.today.year - 1));

for i in 0..7
    offset = rand(Course.count)
    rand_record = Course.offset(offset).first
    name = Faker::GameOfThrones.character.split(/\W+/)
    email = name.first + "@" + name.last + ".com"
    Student.create({:name => name.first, :surname => name.last, :course => rand_record, :dni => (39831178 + i).to_s , :email => email , :s_number => ("123123/3" + i.to_s)  })
end

    