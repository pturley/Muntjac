#!/usr/bin/env ruby

git = `which git`.chomp.gsub(/\/git$/, "")
git_muntjac = git + '/git-muntjac'

`rm -f #{git_muntjac}`