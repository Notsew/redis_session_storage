redis_session_storage
========

#Installation

	gem install redis_session_storage
    
#Usage

Edit config/initializers/session_storage.rb with the following:
	
    Rails.application.config.session_store :redis_session_storage
    
#options

	Rails.application.config.session_store :redis_session_storage, {options}
    
   	:host => the redis host to connect to. Defaults to 127.0.0.1
    :port => the redis port, defaults to 6379
    :db => redis db to use, defaults to 0
    :serializer => Json(:json) or Ruby Marshaller is default
    :key => the prefix for the keys in redis and the name of the cookie
    