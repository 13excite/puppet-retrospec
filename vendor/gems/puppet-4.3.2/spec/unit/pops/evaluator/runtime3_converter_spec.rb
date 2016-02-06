#! /usr/bin/env ruby
require 'spec_helper'

require 'puppet/pops'
require 'puppet/pops/types/type_factory'

describe 'when converting to 3.x' do
  it "converts a resource type starting with Class without confusing it with exact match on 'class'" do
    t = Puppet::Pops::Types::TypeFactory.resource('classroom', 'kermit')
    converted = Puppet::Pops::Evaluator::Runtime3Converter.instance.catalog_type_to_split_type_title(t)
    expect(converted).to eql(['classroom', 'kermit'])
  end

  it "converts a resource type of exactly 'Class'" do
    t = Puppet::Pops::Types::TypeFactory.resource('class', 'kermit')
    converted = Puppet::Pops::Evaluator::Runtime3Converter.instance.catalog_type_to_split_type_title(t)
    expect(converted).to eql(['class', 'kermit'])
  end
end