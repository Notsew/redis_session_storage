require 'redis'
module ActionDispatch
	module Session
    	class RedisSessionStore < AbstractStore

	      def initialize(app, options = {})
	        host = options[:host] || '127.0.0.1'
	        port = options[:port] || 6379
	        db = options[:db] || 0
	        @prefix = options[:key] || ""
	        @serializer = determine_serializer(options[:serializer])
	      	@redis = Redis.new(:host => host, :port => port, :db => db)
	        return super
	      end

	      def get_session(env, session_id)
	        session_id ||= generate_sid()
	        session_data = get_redis_session(prefixed_key(session_id)) || {}
	        return [session_id, session_data]
	      end

	      def set_session(env, session_id, session_data, options)
			begin
				key = prefixed_key(session_id)
		        if session_data
		          if(options[:expire_after])
		          	@redis.setex(key, options[:expire_after], @serializer.dump(session_data))
		          else
		            @redis.set(key, @serializer.dump(session_data))
		          end
		        else
		          @redis.del(key)
		        end
		        return session_id
	    	rescue => e
	    		Rails.logger.error("SessionDispatch::RedisSession - Unable to set redis session.")
	    		return false
	    	end
	      end
	 
	      def destroy_session(env, session_id, options)
			@redis.del(prefixed_key(session_id))
	        return generate_sid()
	      end

	      def determine_serializer(serializer)
	      	if serializer == :json
	      		serial = JsonSerializer
	      	else
	      		serial = Marshal
	      	end
	      	return serial
	      end

	      private

	      def prefixed_key(sid)
	      	return "#{@prefix}#{sid}"
	      end
				 	  
	 	  def get_redis_session(key)
	      	begin
	      		data = @redis.get(key)
	      		data ? @serializer.load(data) : nil
	      	rescue => e
	      		Rails.logger.error("SessionDispatch::RedisSession - Unable to retrieve redis session.")
	      		return nil
	      	end
	      end

		  class JsonSerializer
			def self.load(value)
			    return JSON.parse(value, quirks_mode: true)
			end

			def self.dump(value)
			    return JSON.generate(value, quirks_mode: true)
			end
		  end


	    end
	end
end
