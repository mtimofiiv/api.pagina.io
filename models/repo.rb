class Repo < Sequel::Model

  include Redis::Objects
  include Serializable
  include StandardModel

end
