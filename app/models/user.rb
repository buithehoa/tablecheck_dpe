# app/models/user.rb
class User
  include Mongoid::Document
  field :name, type: String
end
