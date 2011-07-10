#!/usr/bin/env ruby

git = `which git`.chomp.gsub(/\/git$/, "")
muntjac_src = File.expand_path 'muntjac.rb'
git_muntjac = git + '/git-muntjac'

`rm #{git_muntjac}`
`ln -s #{muntjac_src} #{git_muntjac}`