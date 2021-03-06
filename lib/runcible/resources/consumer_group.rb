# Copyright (c) 2012 Red Hat, Inc.
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'active_support/core_ext/hash'

module Runcible
  module Resources
    # @see https://pulp-dev-guide.readthedocs.org/en/latest/rest-api/consumer/group/index.html
    class ConsumerGroup < Runcible::Base

      # Generates the API path for Consumer Groups
      #
      # @param  [String]  id  the ID of the consumer group
      # @return [String]      the consumer group path, may contain the id if passed      
      def self.path(id=nil)
        groups = "consumer_groups/"
        id.nil? ? groups : groups + "#{id}/"
      end
      
      # Creates a Consumer Group
      #
      # @param  [String]                id        the ID of the consumer
      # @param  [Hash]                  optional  container for all optional parameters
      # @return [RestClient::Response]
      def self.create(id, optional={})
        required = required_params(binding.send(:local_variables), binding)
        call(:post, path, :payload => { :required => required, :optional => optional })
      end

      # Retrieves a Consumer Group
      #
      # @param  [String]                id  the ID of the consumer group
      # @return [RestClient::Response]
      def self.retrieve(id)
        call(:get, path(id))
      end

      # Deletes a Consumer Group
      #
      # @param  [String]                id  the ID of the consumer group
      # @return [RestClient::Response]
      def self.delete(id)
        call(:delete, path(id))
      end

      # Associates Consumers with a Consumer Group
      #
      # @param  [String]                id        the ID of the consumer group
      # @param  [Hash]                  criteria  criteria based on Mongo syntax representing consumers to associate
      # @return [RestClient::Response]
      def self.associate(id, criteria)
        call(:post, path(id) + "actions/associate/", :payload => {:required => criteria})
      end

      # Unassociates Consumers with a Consumer Group
      #
      # @param  [String]                id        the ID of the consumer group
      # @param  [Hash]                  criteria  criteria based on Mongo syntax representing consumers ta unassociate
      # @return [RestClient::Response]
      def self.unassociate(id, criteria)
        call(:post, path(id) + "actions/unassociate/", :payload => {:required => criteria})
      end

      # Install a set of units to a Consumer Group
      #
      # @param  [String]                id      the ID of the consumer group
      # @param  [Array]                 units   array of units to install
      # @param  [Hash]                  options hash of install options
      # @return [RestClient::Response]
      def self.install_units(id, units, options={})
        required = required_params(binding.send(:local_variables), binding, ["id"])
        call(:post, path("#{id}/actions/content/install"), :payload => { :required => required })
      end

      # Update a set of units on a Consumer Group
      #
      # @param  [String]                id      the ID of the consumer group
      # @param  [Array]                 units   array of units to update
      # @param  [Hash]                  options hash of update options
      # @return [RestClient::Response]
      def self.update_units(id, units, options={})
        required = required_params(binding.send(:local_variables), binding, ["id"])
        call(:post, path("#{id}/actions/content/update"), :payload => { :required => required })
      end

      # Uninstall a set of units from a Consumer Group
      #
      # @param  [String]                id      the ID of the consumer group
      # @param  [Array]                 units   array of units to uninstall
      # @param  [Hash]                  options hash of uninstall options
      # @return [RestClient::Response]
      def self.uninstall_units(id, units, options={})
        required = required_params(binding.send(:local_variables), binding, ["id"])
        call(:post, path("#{id}/actions/content/uninstall"), :payload => { :required => required })
      end

    end
  end
end
