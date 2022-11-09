BEGIN {
  FS="\n";RS=""
  print "package models" > "./backend/domain/models/models.gen.go"
}

/package/ {
  print $0"\n" > "./backend/adapters/types.gen.go"
}

/const\s\(.*\)/ {
  print $0"\n" >> "./backend/domain/models/models.gen.go"
}

!/^\/\// && /.*\}$/ {
  print $0"\n" >> "./backend/domain/models/models.gen.go"
}

/type\s\S*\sstruct\s\{.*/ {
  print $0"\n" >> "./backend/domain/models/models.gen.go"
  match($0, /type\s(.*)\sstruct/, a)
  print "type "a[1]" = models."a[1]"\n" >> "./backend/adapters/types.gen.go"
}

/import\s\(.*\)/ {
  print $0"\n" >> "./backend/domain/models/models.gen.go"
  print $1 >> "./backend/adapters/types.gen.go"
  print $2 >> "./backend/adapters/types.gen.go"
  print "\"github.com/CharVstack/CharV-backend/domain/models\"" >> "./backend/adapters/types.gen.go"
  print $3"\n" >> "./backend/adapters/types.gen.go"
}

/type\s\S*\s\S*$/ {
  print $0"\n" >> "./backend/domain/models/models.gen.go"
  match($0, /type\s(.*)\s(.*)/, a)
  print "type "a[1]" = models."a[1]"\n" >> "./backend/adapters/types.gen.go"
}

/type\s\S*\s=\s\S*$/ {
  match($0, /type\s(.*)\s=\s(.*)/, a)
  print "type "a[1]" = models."a[2]"\n" >> "./backend/adapters/types.gen.go"
}
