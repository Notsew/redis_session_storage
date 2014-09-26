# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :redis_session_store, {:key => 'dummy_session_', :expire_after => 5.minutes}