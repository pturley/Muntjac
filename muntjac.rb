#!/usr/bin/env ruby

if ARGV.length > 1 || (ARGV.length == 0 && !File.exists?(".git/team.txt"))
  puts "Useage: git muntjac [<team>]"
  puts 
  puts "        <team> : comma separated regular expresions of team members"
  exit 0
end

old_team = File.read(".git/team.txt") if File.exists?(".git/team.txt")
team = ARGV[0] if ARGV[0]
team ||= old_team
File.open(".git/team.txt", "wb") { |file| file << team }

full_log = `git log`
commits = full_log.split(/^commit/)

matched_commits = []
team.split(",").each do |team_member|
  commits.each {|commit| matched_commits << commit if Regexp.new(team_member.strip, true).match(commit) }
end

puts matched_commits
