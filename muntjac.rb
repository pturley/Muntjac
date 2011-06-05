#!/usr/bin/env ruby

def should_print_useage?
  ARGV.length > 1 || (ARGV.length == 0 && !File.exists?(".git/team.txt"))
end

def print_useage
  puts "Useage: git muntjac [<team>]"
  puts 
  puts "        <team> : comma separated regular expresions of team members"
  exit 0
end

def team
  old_team = File.read(".git/team.txt") if File.exists?(".git/team.txt")
  team_members = ARGV[0] if ARGV[0]
  team_members ||= old_team
  File.open(".git/team.txt", "wb") { |file| file << team_members }
  puts "Processing repo for team: #{team_members}"
  puts
  team_members
end

def all_commits
  `git log`.split(/^commit/)
end

def find_matched_commits(team_members, commits)
  matched_commits = []
  team_members.split(",").each do |team_member|
    commits.each {|commit| matched_commits << "commit #{commit}" if Regexp.new(team_member.strip, true).match(commit) }
  end
  matched_commits
end

print_useage if should_print_useage?
puts find_matched_commits(team, all_commits)