# Insert predefined tag to database
PREDEFINED_TAGS = [
  { name: "ai", description: "Artificial Intelligence, Machine Learning", is_media: false },
  { name: "ask", description: "Ask 0xblockchain", is_media: false },
  { name: "c", description: "C programming language", is_media: false },
  { name: "cpp", description: "C++ programming language", is_media: false },
  { name: "cryptocurrency", description: "Bitcoin and other cryptocurrencies", is_media: false },
  { name: "dapps", description: "Decentralized apps", is_media: false },
  { name: "database", description: "Databases (SQL, NoSQL)", is_media: false },
  { name: "distsys", description: "Distributed system", is_media: false },
  { name: "ethereum", description: "Ethereum related links", is_media: false },
  { name: "finance", description: "Finance and economics", is_media: false },
  { name: "go", description: "Go programming language", is_media: false },
  { name: "hardware", description: "GPU and other hardwares", is_media: false },
  { name: "ipfs", description: "InterPlanetary File System", is_media: false },
  { name: "js", description: "JavaScript programming language", is_media: false },
  { name: "law", description: "Law, patents, and licensing", is_media: false },
  { name: "lua", description: "Lua programming language", is_media: false },
  { name: "meta", description: "0xblockchain-related bikeshedding", is_media: false },
  { name: "mobile", description: "Mobile app/web development for iOS, android and other mobile OSes", is_media: false },
  { name: "networking", description: "Networking related links", is_media: false },
  { name: "p2p", description: "Peer-to-peer (P2P) computing or networking", is_media: false },
  { name: "pdf", description: "Link to pdf", is_media: true },
  { name: "person", description: "Stories about particular persons", is_media: false },
  { name: "practice", description: "Development and business practices", is_media: false },
  { name: "privacy", description: "Privacy related links", is_media: false },
  { name: "protocol", description: "Blockchain protocols", is_media: false },
  { name: "release", description: "Software releases and announcements", is_media: false },
  { name: "research", description: "Research project links", is_media: false },
  { name: "rust", description: "Rust programming language", is_media: false },
  { name: "scala", description: "Scala programming language", is_media: false },
  { name: "show", description: "Show blockchain related projects", is_media: false },
  { name: "slide", description: "Link to slide", is_media: true },
  { name: "smart-contract", description: "Smart contract related links", is_media: false },
  { name: "solidity", description: "Solidity programming language", is_media: false },
  { name: "swift", description: "Swift programming language", is_media: false },
  { name: "ts", description: "TypeScript programming language", is_media: false },
  { name: "video", description: "Link to video", is_media: true },
  { name: "wallet", description: "Wallet", is_media: false },
  { name: "web3", description: "Web3 links", is_media: false },
  { name: "whitepaper", description: "Technical whitepaper", is_media: false },
].freeze

PREDEFINED_TAGS.each do |tag|
  Tag.create(
    :tag => tag[:name],
    :description => tag[:description],
    :is_media => tag[:is_media]
  )
  puts "Tag %s is created" % tag[:name]
end
