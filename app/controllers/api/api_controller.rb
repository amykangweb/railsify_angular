class Api::ApiController < ApiController
  skip_before_filter :api_session_token_authenticate!, only: [:index]
end
