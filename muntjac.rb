#!/usr/bin/env ruby

TEAM_FILE = ".git/team.txt"

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
  old_team = File.read(TEAM_FILE) if File.exists?(TEAM_FILE)
  team_members = ARGV[0] if ARGV[0]
  team_members ||= old_team
  File.open(TEAM_FILE, "wb") { |file| file << team_members }
  puts "Processing repo for team: #{team_members}"
  puts
  team_members
end

def all_commits
  `git log`.split(/^commit/)
end

def find_matched_commits(team_members, commits)
  matched_commits = []
  commits.each do |commit| 
    team_members.split(",").each do |team_member|
      matched_commits << colored_commit(commit) if Regexp.new(team_member.strip, true).match(commit)
    end
  end
  matched_commits.uniq
end

def colored_commit(commit)
  sha = commit.split("\n").first
  other_commit_lines = commit.split("\n").drop(1)
  sha_line = "\e[0;33mcommit #{sha}\e[0;37m"

  [sha_line, other_commit_lines].flatten.join("\n")
end

print_usage if should_print_usage?
puts find_matched_commits(team, all_commits)