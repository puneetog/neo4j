class Micropost
    include Neo4j::ActiveNode
    property :id
    property :content, type: String
    #property :created_at, type: DateTime
  #  property :updated_at, type: DateTime
    validates :content, presence: true, length: { maximum: 140 }

    has_one(:user).from(:microposts)
end