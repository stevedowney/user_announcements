User.create!(name: 'steve') unless User.find_by_name('steve')
User.create!(name: 'bob') unless User.find_by_name('bob')