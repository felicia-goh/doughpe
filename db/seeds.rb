User.destroy_all

User.create!(email: "baker@me.com", password:"testtest",baker:true, username:"baker")
User.create!(email: "customer@me.com", password:"testtest",baker:false,username:"customer")
