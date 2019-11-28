verticals_file = File.read(Rails.root.join('public/data/verticals.json'))
categories_file = File.read(Rails.root.join('public/data/categories.json'))
courses_file = File.read(Rails.root.join('public/data/courses.json'))

verticals_data = JSON.parse(verticals_file)
categories_data = JSON.parse(categories_file)
courses_data = JSON.parse(courses_file)

verticals_data.each do |vertical_params|
  attributes = {
    name: vertical_params['Name']
  }
  vertical = Vertical.create!(attributes)

  categories_data.select do |cat|
    cat['Verticals'] == vertical_params['Id']
  end.each do |category_params|
    attributes = {
      vertical: vertical,
      name: category_params['Name'],
      state: category_params['State']
    }

    category = Category.create!(attributes)

    courses_data.select do |cor|
      cor['Category'] == category_params['Id']
    end.each do |course_params|
      attributes = {
        category: category,
        name: course_params['Name'],
        author: course_params['Author'],
        state: course_params['State']
      }
      Course.create!(attributes)
    end
  end
end
