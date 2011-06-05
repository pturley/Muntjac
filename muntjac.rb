#!/usr/bin/env ruby

old_repo = File.read("repo.txt") if File.exists?("repo.txt")
print "Where is your repository#{' ('+old_repo+')' if old_repo}? "
repo = gets.chomp
repo = old_repo if repo.empty?
File.open("repo.txt", "wb") { |file| file << repo }

old_team = File.read("team.txt") if File.exists?("team.txt")
print "Who is on your team comma separated or regexp#{' ('+old_team+')' if old_team}? "
team = gets.chomp
team = old_team if team.empty?
File.open("team.txt", "wb") { |file| file << team }


full_log = `cd #{repo} && git log`
commits = full_log.split(/^commit/)

matched_commits = []
team.split(",").each do |team_member|
  commits.each {|commit| matched_commits << commit if Regexp.new(team_member.strip, true).match(commit) }
end

puts matched_commits
