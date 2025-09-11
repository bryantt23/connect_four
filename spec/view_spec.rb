# spec/view_spec.rb
require 'spec_helper'
require_relative '../lib/view'

RSpec.describe View do
  describe '#welcome' do
    it 'prints the welcome message' do
      view = View.new
      expect { view.welcome }.to output("Welcome to Connect Four!\n").to_stdout
    end
  end
end
