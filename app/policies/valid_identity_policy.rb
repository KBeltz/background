##
# checks the validity of a User
# or BlockScore::Person instance
#
#  ValidIdentityPolicy.call(user: current_user)
#  #=> true/false
#
#  ValidIdentityPolicy.call(user: current_user) do |result|
#    redirect root_path, error: result.message unless result.status
#  end
class ValidIdentityPolicy
  ##
  # creates a policy instance, gets the
  # validity result, optionally passes
  # results to a block and returns the
  # status of the policy check
  def self.call(params)
    policy = new(params)
    result = policy.valid?
    yield(result) if block_given?
    result.status
  end

  ##
  # expects either :user or :person keys
  # to be passed and will fail if neither
  # is given
  def initialize(params)
    @person = params.fetch(:person, false)
    @user = params.fetch(:user, false)
    fail ArgumentError, 'Requires a :user or :person' unless @user || @person
  end

  ##
  # should be called with a either a @user
  # or @person, and will check @user
  # over checking :person. Will return a
  # PolicyResult instance with a status and
  # message
  def valid?
    if @user && !(@user.identified && @user.identifiable_id)
      PolicyResult.new(message: 'Not identified')
    elsif @person && !@person.valid?
      PolicyResult.new(message: 'Invalid identity')
    else
      PolicyResult.new(status: true)
    end
  end
end