#!/usr/bin/env ruby

team_file = ".git/team.txt"

def display_help?
  team_file = ".git/team.txt"
  ARGV.length > 1 or
  (ARGV.length == 0 and !File.exists?(team_file)) or
  ARGV[1] == 'help'
end

if display_help?
  puts "Usage: git muntjac [<team>]"
  puts
  puts "        <team> : comma separated regular expressions of team members"
  exit 0
end

old_team = File.read(team_file) if File.exists?(team_file)
team = ARGV[0] if ARGV[0]
team ||= old_team
File.open(team_file, "wb") { |file| file << team }

full_log = `git log`
commits = full_log.split(/^commit/)

matched_commits = team.split(",").inject [] do |matches, team_member|
  matches.concat commits.select { |commit| Regexp.new(team_member.strip, true).match(commit) }
end

puts matched_commits
