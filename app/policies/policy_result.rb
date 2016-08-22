##
# A plain old ruby object to help collect the
# status and message returned from a policy check
class PolicyResult
  attr_reader :message, :status

  ##
  # :attr_accessor: message
  # a small message about explaining the status
  # defaults to :no_message

  ##
  # :attr_accessor: status
  # a Boolean value representing the result of a
  # policy check

  ##
  # expects params with optional :status and :message
  def initialize(params)
    @status = params.fetch(:status, false)
    @message = params.fetch(:message, :no_message)
  end
end