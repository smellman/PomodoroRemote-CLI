#!/usr/bin/env ruby

lib = File.expand_path('../../example/couchbase-lite-local/lib', __FILE__)
puts lib
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'couchbase_lite_local'

couchbase_lite_local = CouchbaseLiteLocal.start

output = File.open('current_server', 'w')
output.write(couchbase_lite_local.url)
output.close

puts <<-EOF
  Running local couchbase lite instance

  username: #{couchbase_lite_local.login}
  password: #{couchbase_lite_local.password}

  #{couchbase_lite_local.url}
EOF

trap("SIGINT") { exit! }

# これをサービス側に仕込んでおけばいいんだけどloopの中は破滅が起きそう...
# pull replication
# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"source" : "http://54.64.39.70:4985/pomodoro_remote", "target" : "pomodoro_remote"}' http://98aade98-1b64-49eb-bc90-e2da41618dec:c1e2117e-add5-4c71-bc36-f03b9d7ea08c@localhost:5984/_replicate
# push replication
# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"target" : "http://54.64.39.70:4985/pomodoro_remote", "source" : "pomodoro_remote"}' http://98aade98-1b64-49eb-bc90-e2da41618dec:c1e2117e-add5-4c71-bc36-f03b9d7ea08c@localhost:5984/_replicate


loop do
  puts "Press Ctrl-C to shutdown"
  STDIN.gets
end
