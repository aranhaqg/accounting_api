class AccountNotFoundError < StandardError

  attr_reader :account_type

  def initialize(account_type)
    case account_type
    when AccountTypes::SOURCE
    	msg = Il8n.t 'errors.source_account_not_found'
    when AccountTypes::DESTINATION
    	msg = Il8n.t 'errors.destination_account_not_found'
    end	
    super(msg)
  end

end