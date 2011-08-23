load File.expand_path('../boot.rb', __FILE__)
require 'yourapp'

class CreateTable < ActiveRecord::Migration
  def self.up
    create_table(:visits) do |t|
      t.string :remote_ip
      t.timestamps
    end
  end
end

namespace :db do
  desc "aah, the migration!"
  task :migrate do
    CreateTable.migrate(:up) unless Visit.table_exists?
  end
end

task :console do
  require 'pry'
  Pry.start
end
