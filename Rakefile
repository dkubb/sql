# encoding: utf-8

require 'devtools'

Devtools.init_rake_tasks

# Compile the scanner using ragel
rule '.rb' => '.rb.rl' do |task|
  sh "ragel -I. -R -o #{task.name} #{task.source}"
end

# Compile the parser using racc
rule '.rb' => '.rb.y' do |task|
  sh "racc -l -o #{task.name} #{task.source}"
end

desc 'Compile the scanner and parser'
task :compile => %w[clean lib/sql/scanner.rb lib/sql/parser.rb]

desc 'Clean up compiled code'
task :clean do
  sh 'git clean -dfx lib/sql/{scanner,parser}.rb'
end

# Add compile as a dependency to spec tasks
%w[spec spec:unit spec:integration].each do |task_name|
  task(task_name => :compile)
end
