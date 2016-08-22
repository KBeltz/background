##
# A class to handle an identity creation on
# BlockScore
#
# We put this in it's own file so that we can isolate a few concerns:
#
# * Posting data to the API
# * Saving the corresponding relevant data to the DB
# * Handling possible errors
#
# Thus we are able to isolate the interaction between a major action involving a User and BlockScore in its class.
#
#  creds = {name_first: "John Doe", ... }
#  identity_params = { user: current_user, credentials: creds }
#  CreateIdentity.call(identity_params)
#  #=> true/false
#
class CreateIdentity
  ##
  # creates an instance using the provided params
  # then calls CreateIdentity#create
  def self.call(params)
    identity = new(params)
    identity.create
  end

  ##
  # requires params with both :user and :credentials
  def initialize(params)
    @user = params.fetch(:user)
    @credentials = params.fetch(:credentials)
  end

  ##
  # check the credentials of a identity
  # and saves the Person to the user if
  # the
  def create
    create_person
    @user.identified
  end

  private

  ##
  # creates a Person with the credentials provided
  # using the BlockScore API. See also
  # BlockScore::Person#create
  def create_person
    @person = BlockScore::Person.create(@credentials)
    @user.identified = valid?
    @user.identifiable_id = @person.id
    @user.save
  rescue BlockScore::InvalidRequestError
    false
  end

  ##
  # check the validity of an identity
  # using person
  def valid?
    ValidIdentityPolicy.call(person: @person)
  end
end