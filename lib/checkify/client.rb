module Checkify
  # A client with its own credentials, configuration, and endpoint groups.
  class Client
    attr_reader :account, :address, :batch, :business, :communication, :identity

    def initialize(api_key:, timeout: 30)
      unless api_key.is_a?(String) && !api_key.strip.empty?
        raise ArgumentError, "api_key must be a nonblank String"
      end

      config = Configuration.new
      config.access_token = api_key
      config.timeout = timeout
      yield config if block_given?

      api_client = ApiClient.new(config)
      @account = AccountApi.new(api_client)
      @address = AddressApi.new(api_client)
      @batch = BatchApi.new(api_client)
      @business = BusinessApi.new(api_client)
      @communication = CommunicationApi.new(api_client)
      @identity = IdentityApi.new(api_client)
    end
  end
end
