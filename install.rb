#!/usr/bin/env ruby

git_location = `which git`.chomp
git_location.gsub!(/\/git$/, "")

`ln -s #{File.expand_path 'muntjac.rb'} #{git_location+'/git-muntjac'}`