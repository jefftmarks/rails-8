Product.delete_all

product = Product.create(
  title: 'Chicken\'s Pea Pods',
  description: 'Words cannot describe',
  price: 1
)

product.image.attach(
  io: File.open(Rails.root.join('db', 'images', 'peas.jpg')),
  filename: 'peas.jpg'
)

product.save!

product = Product.create(
  title: 'Randall',
  description: 'Missing part of his tail',
  price: 0.5
)

product.image.attach(
  io: File.open(Rails.root.join('db', 'images', 'peas.jpg')),
  filename: 'peas.jpg'
)

product.save!
