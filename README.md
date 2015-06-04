

API keys by Project? Person? User? Organization? No problem!  

HasApiKey allows you to add 1 line to any of your models and enable API key storage.

# Usage

## Samples
Add the `has_api_key` declaration to the model that you want to associate API keys with:

```ruby
  class Person < ActiveRecord::Base
    has_api_key
  end
```

Authenticate in your API-enabled controllers by including the Authenticator module:

```ruby
  class PeopleController < ActionController::Base
    include HasApiKey::Authenticator

    def index
      render text: "Victory is mine!"
    end
  end 
```

Access the resource associated with your API token by checking the `@api_loaded_resource` instance variable in your controller.

## Authentication Types

API tokens have to be passed in as a `token` param for the `Authenticator` to check it correctly. You can also optionally pass it in via HTTP header. In `curl` this would be:

```bash
curl -IH "Authorization: Token token=b67a8e54b11c411e5a4a35x734c80a11z" http://localhost:3000/people
```

## TODO

* Tests for migration generator
* Allow API resource instance variable name to be customized
* Allow API token param name to be customized
* Add the ability to generate new keys per resource and maintain key history
* Allow keys to be reset on a specific resource via a `reset!` helper method

Built with <3 by buttercloud.



