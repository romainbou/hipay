require 'savon'

module Hipay
  class Client
    class SOAP

      def initialize opts
        @options = opts.with_indifferent_access
        @client = Savon.client wsdl: @options.delete(:wsdl)
      end

      def call method, params, opts= {}, &block
        response = @client.call method, opts.update(:message => { :parameters => @options.merge(params)}), &block
        hash = response.body[:"#{method}_response"][:"#{method}_result"].with_indifferent_access
        code = hash.delete(:code).to_i
        if code > 0
          raise Error.new "Code #{code} : #{hash[:description]}"
        else
          hash
        end
      end

      def method_missing name, *params, &block
        if @client.respond_to? name
          @client.send name, *params, &block
        else
          super
        end
      end

      class Error < StandardError; end

    end
  end
end