class NotEnoughBalanceError < StandardError

  attr_reader :account_id

  def initialize(account_id)
  	msg = Il8n.t('errors.not_enough_balance', account_id: account_id) 
    super(msg)
  end

end