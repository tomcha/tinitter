#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra/base'
require 'haml'
require 'active_record'

class Tinitter < Sinatra::Base
  configure do
    DB.connect(
      File.expand_path(File.join(root, '..')),
      [RACK_ENV])
  end

  set :public_folder, File.expand_path(File.join(root, '..', 'public'))
end


