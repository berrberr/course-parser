require 'mongo'

include Mongo

mongo_client = MongoClient.new('localhost', 27017)

db = mongo_client.db('courses')

coll = db.collection('test')
coll.insert({
  "name" => "cs1",
  "id" => 1
})

puts coll.inspect
