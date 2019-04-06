module Exceptions
  class AccountNotFoundError < StandardError

    attr_reader :account_type

    def initialize(account_type)
      case account_type
      when AccountTypes::SOURCE
      	msg = I18n.t 'errors.source_account_not_found'
      when AccountTypes::DESTINATION
      	msg = I18n.t 'errors.destination_account_not_found'
      end	
      super(msg)
    end
  end
end
