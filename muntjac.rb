#!/usr/bin/env ruby

def should_print_usage?
  ARGV.length > 1 || (ARGV.length == 0 && !File.exists?(".git/team.txt"))
end

def print_usage
  puts "Usage: git muntjac [<team>]"
  puts 
  puts "        <team> : comma separated regular expressions of team members"
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

print_usage if should_print_usage?
puts find_matched_commits(team, all_commits)