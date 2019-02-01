require('pry')
require_relative('../models/Member.rb')
require_relative('../models/GymClass.rb')

@member0 = Member.new({
  'first_name' => 'Ian',
  'last_name' => 'Bone',
  'premium' => 'TRUE',
  'telephone' => '07886666778',
  'email' => 'ianbone1@googlemail.com',
  'address_line_1' => '79 Hawthorn Crescent',
  'address_line_2' => '',
  'town' => 'Erskine',
  'district' => 'Renfrewshire',
  'post_code' => 'PA8 7BY'}
)
@member0.save

@member1 = Member.new({
  'first_name' => 'Joe',
  'last_name' => 'Bloggs',
  'premium' => 'TRUE',
  'telephone' => '07884338232',
  'email' => 'jo@googlemail.com',
  'address_line_1' => 'Joe Street ',
  'address_line_2' => '',
  'town' => 'JoeTown',
  'district' => 'Renfrewshire',
  'post_code' => 'J04 7BY'}
)

@member1.save

@member2 = Member.new({
  'first_name' => 'Bob',
  'last_name' => 'McBobface',
  'premium' => 'FALSE',
  'telephone' => '0788434456789',
  'email' => 'bob@googlemail.com',
  'address_line_1' => 'Bobtown',
  'address_line_2' => '',
  'town' => 'Bobville',
  'district' => 'Renfrewshire',
  'post_code' => 'BO8 B0Y'}
)

@member2.save

@gymclass0 = GymClass.new({
      'name' => 'Metafit',
      'description' => 'One of the hardest, killing classes ont he planet!'}
    )

@gymclass0.save

@gymclass1 = GymClass.new({
      'name' => 'Crossfit',
      'description' => 'Another nightmare from hell!'}
    )

@gymclass1.save

@gymclass2 = GymClass.new({
      'name' => 'Spin',
      'description' => 'You may think you are, but you are really not pedaling past enough!'}
    )

@gymclass2.save


binding.pry

nil
