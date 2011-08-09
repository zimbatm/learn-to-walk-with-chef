load File.expand_path('../boot.rb', __FILE__)
require 'bundler/task'

require 'yourapp_model'


class CreateTable < ActiveRecord::Migration
  def self.up
    create_table(:visits) do |t|
      t.id
      t.string :remote_ip
      t.timestamps
    end
  end
end
