require 'sinatra'
require "slim"
require "sinatra/reloader"
require "sqlite3"


post("/fruits/:id/delete") do

  id = params[:id].to_i
  db = SQLite3::Database.new('db/fruits.db')

  db.execute("DELETE FROM fruits WHERE id = ?", id)

  redirect("/fruits")
end

get("/fruits/:id/edit") do

  db = SQLite3::Database.new('db/fruits.db')
  db.results_as_hash = true
  id = params[:id].to_i
  @special_frukt = db.execute("SELECT * FROM fruits WHERE id = ?", id).first

  slim(:"fruits/edit")
      
end

post("/fruits/:id/update") do

  id = params[:id].to_i
  name = params[:name]
  amount = params[:amount].to_i

  db = SQLite3::Database.new('db/fruits.db')
  db.execute("UPDATE fruits SET name=?, amount=? WHERE id=?",[name,amount,id])

  redirect("/fruits")

end

get('/') do
  #slim(:home)
  redirect('/home')

end

get('/home') do
  
  slim(:home)

end


get('/about') do
  
  slim(:about)

end

get('/fruits1') do

  @fruits = ["Äpple", "Banan", "Apelsin"]
  slim(:fruits1)

end

get("/fruits/new") do

  slim(:"fruits/new")

end

post("/fruit") do 

  new_fruit = params[:new_fruit]
  amount = params[:amount].to_i
  
  db = SQLite3::Database.new('db/fruits.db')
  db.execute("INSERT INTO fruits (name, amount) VALUES (?,?)",[new_fruit,amount])
  
  redirect("/fruits")

end

get("/fruits") do
  
  query = params[:q]

  p "Jag skrev #{query}"

  db = SQLite3::Database.new("db/fruits.db")

  db.results_as_hash = true

  @datafruits = db.execute("SELECT * FROM fruits")

  if query && !query.empty?
    @datafruits = db.execute("SELECT * FROM fruits WHERE name LIKE ?","%#{query}%")
  else
    @datafruits = db.execute("SELECT * FROM fruits")
  end

  p @datafruits

  slim(:index)

end

get('/fruits/:id') do

  @fruit = params[:id]
  slim(:youlike)

end

get('/fruktinfo') do

  @flutts = [
    {
      "name" => "One",
      "color" => "green",
      "age" => "2",
      "price" => "13.37"
    },
    {
      "name" => "Two",
      "color" => "red",
      "age" => "1",
      "price" => "12.37"
    }
  ]

  slim(:fruktinfo)

end

# animals

get("/animals") do
  
  query = params[:q]

  p "Jag skrev: #{query}"

  db = SQLite3::Database.new("db/animals.db")

  db.results_as_hash = true

  @dataanimals = db.execute("SELECT * FROM animals")

  if query && !query.empty?
    @dataanimals = db.execute("SELECT * FROM animals WHERE name LIKE ?","%#{query}%")
  else
    @dataanimals = db.execute("SELECT * FROM animals")
  end

  p @dataanimals

  slim(:"animals/index")

end

get("/animals/new") do

  slim(:"animals/new")

end

post("/animal") do 

  new_animal = params[:new_animal]
  amount = params[:amount].to_i
  
  db = SQLite3::Database.new('db/animals.db')
  db.execute("INSERT INTO animals (name, amount) VALUES (?,?)",[new_animal,amount])
  
  redirect("/animals")

end

post("/animals/:id/delete") do

  id = params[:id].to_i
  db = SQLite3::Database.new('db/animals.db')

  db.execute("DELETE FROM animals WHERE id = ?", id)

  redirect("/animals")
end

get("/animals/:id/edit") do

  db = SQLite3::Database.new('db/animals.db')
  db.results_as_hash = true
  id = params[:id].to_i
  @special_djur = db.execute("SELECT * FROM animals WHERE id = ?", id).first

  slim(:"animals/edit")
      
end

post("/animals/:id/update") do

  id = params[:id].to_i
  name = params[:name]
  amount = params[:amount].to_i

  db = SQLite3::Database.new('db/animals.db')
  db.execute("UPDATE animals SET name=?, amount=? WHERE id=?",[name,amount,id])

  redirect("/animals")

end