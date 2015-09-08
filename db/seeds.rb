# Create root and Counter A-J (10 counters)
# TODO: output something to STDOUT so when you run db:seed you can see something moving :)
User.create!([
{ username: 'root', name: 'Administrator', password: 'iamroot' },
{ username: 'cta', name: 'Counter A', password: 'cta' },
{ username: 'ctb', name: 'Counter B', password: 'ctb' },
{ username: 'ctc', name: 'Counter C', password: 'ctc' },
{ username: 'ctd', name: 'Counter D', password: 'ctd' },
{ username: 'cte', name: 'Counter E', password: 'cte' },
{ username: 'ctf', name: 'Counter F', password: 'ctf' },
{ username: 'ctg', name: 'Counter G', password: 'ctg' },
{ username: 'cth', name: 'Counter H', password: 'cth' },
{ username: 'cti', name: 'Counter I', password: 'cti' },
{ username: 'ctj', name: 'Counter J', password: 'ctj' }
])

Product.create!([
{ name: 'เสื้อยืด สามัคฯ  S', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อยืด สามัคฯ  M', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อยืด สามัคฯ  L', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อยืด สามัคฯ  XL', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อยืด 5 แทบ S', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อยืด 5 แทบ M', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อยืด 5 แทบ L', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อยืด 5 แทบ XL', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อยืด 5 แทบ XXL', cost: 0, price: 200, hidden: false},
{ name: 'เสื้อแขนยาว S', cost: 0, price: 250, hidden: false},
{ name: 'เสื้อแขนยาว M', cost: 0, price: 250, hidden: false},
{ name: 'เสื้อแขนยาว L', cost: 0, price: 250, hidden: false},
{ name: 'เสื้อแขนยาว XL', cost: 0, price: 250, hidden: false},
{ name: 'เสื้อแขนยาว XXL', cost: 0, price: 250, hidden: false},
{ name: 'เสื้อโปโล S', cost: 0, price: 350, hidden: false},
{ name: 'เสื้อโปโล M', cost: 0, price: 350, hidden: false},
{ name: 'เสื้อโปโล L', cost: 0, price: 350, hidden: false},
{ name: 'เสื้อโปโล XL', cost: 0, price: 350, hidden: false},
{ name: 'เสื้อโปโล XXL', cost: 0, price: 350, hidden: false},
{ name: 'เสื้อเบสเบอล S', cost: 0, price: 350, hidden: false},
{ name: 'เสื้อเบสเบอล M', cost: 0, price: 350, hidden: false},
{ name: 'เสื้อเบสเบอล L', cost: 0, price: 350, hidden: false},
{ name: 'เสื้อเบสเบอล XL', cost: 0, price: 350, hidden: false},
{ name: 'แฟ้มเอกสาร', cost: 0, price: 30, hidden: false},
{ name: 'แท็กกระเป๋า', cost: 0, price: 60, hidden: false},
{ name: 'สมุดปกแข็ง', cost: 0, price: 60, hidden: false},
{ name: 'ถุงผ้าสีดำ', cost: 0, price: 150, hidden: false},
{ name: 'ถุงผ้าใหญ่', cost: 0, price: 200, hidden: false},
{ name: 'Teddy Bear', cost: 0, price: 250, hidden: false},
{ name: 'Big Teddy Bear', cost: 0, price: 500, hidden: false},
{ name: 'กระเป๋าเอกสาร', cost: 0, price: 250, hidden: false},
{ name: 'กระเป๋าเป้', cost: 0, price: 450, hidden: false},
{ name: 'ถุงกระดาษ', cost: 0, price: 30, hidden: false}
])

Combo.create!([
{ name: 'KID SET', products: '[[1,2,3,4,5,6,7,8,9],24,25,26,27]', price: 450, hidden: false },
{ name: 'Teddy Bear Family', products: '[29,30]', price: 675, hidden: false },
{ name: 'Regular Set', products: '[[1,2,3,4,5,6,7,8,9],[10,11,12,13,14],[15,16,17,18,19],28,31,24,25,26,33]', price: 1300, hidden: false },
{ name: 'Deluxe Set', products: '[[1,2,3,4],[5,6,7,8,9],[10,11,12,13,14],[15,16,17,18,19],[20,21,22,23],24,25,26,27,28,29,30,31,32,33]', price: 3000, hidden: false }
])
