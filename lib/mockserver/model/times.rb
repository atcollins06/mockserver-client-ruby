# encoding: UTF-8
require 'hashie'

#
# A class to model the number of times an expectation should be respected.
# @author:: Nayyara Samuel (mailto: nayyara.samuel@opower.com)
#
module MockServer::Model
  # Model for times class
  class Times < Hashie::Dash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IgnoreUndeclared

    property :remaining_times, default: 0
    property :unlimited, default: false
  end

  # DSL methods related to times
  module DSL
    def unlimited
      Times.new(unlimited: true)
    end

    def once
      Times.new(remaining_times: 1)
    end

    def exactly(num)
      Times.new(remaining_times: num)
    end

    def at_least(num)
      Times.new(remaining_times: num, unlimited: true)
    end

    def times(&_)
      obj = once
      yield obj if block_given?
      obj
    end
  end
end
