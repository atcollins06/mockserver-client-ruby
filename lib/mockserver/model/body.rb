# encoding: UTF-8
require 'hashie'
require_relative './parameter'
require_relative './enum'

#
# A model for a a body in a request object.
# @author: Nayyara Samuel (mailto: nayyara.samuel@opower.com)
#
module MockServer::Model
  # An enum for body type
  class BodyType < SymbolizedEnum
    def allowed_values
      [:STRING, :REGEX, :JSON_SCHEMA, :XPATH, :PARAMETERS, :BINARY]
    end
  end

  # A model for a a body in a request object.
  class Body < Hashie::Dash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    property :type, required: true
    property :value
    property :regex
    property :jsonSchema
    property :xpath
    property :parameters

    coerce_key :type, BodyType
    coerce_key :value, String
    coerce_key :regex, String
    coerce_key :jsonSchema, String
    coerce_key :xpath, String
    coerce_key :parameters, Parameters
  end

  # DSL methods related to body
  module DSL
    # For response object where body can only be a string
    def body(value)
      value
    end

    def exact(value)
      Body.new(type: :STRING, string: value)
    end

    def regex(value)
      Body.new(type: :REGEX, regex: value)
    end

    def xpath(value)
      Body.new(type: :XPATH, xpath: value)
    end

    def json_schema(value)
      Body.new(type: :JSON_SCHEMA, jsonSchema: value)
    end

    def parameterized(*parameters)
      Body.new(type: :PARAMETERS, parameters: parameters)
    end
  end
end
