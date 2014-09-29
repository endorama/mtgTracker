require "sinatra/base"
 
module Sinatra
  module ErrorHandling
 
    module Helpers
      def halt_with_400(message = nil)
        message ||= "Bad request"
        halt 400, json(message: message, data: nil)
      end
 
      def halt_with_401(message = nil)
        message ||= "Authorization required"
        halt 401, json(message: message, data: nil)
      end
 
      def halt_with_403(message = nil)
        message ||= "Forbidden"
        halt 403, json(message: message, data: nil)
      end
 
      def halt_with_404
        halt 404, json(message: "Record not found", data: nil)
      end
 
      def halt_with_422
        errors = []
        
        resource = env['sinatra.error'].record.class.to_s
        env['sinatra.error'].record.errors.each do |attribute, message|
 
          case message
            when "can't be blank"
              code = "missing_field"
            when "has already been taken"
              code = "already_exists"
            else
              code = "invalid"
          end
 
          errors << {
            resource: resource,
            field: attribute,
            code: code
          }
        end
        halt 422, json({
          message: "Validation failed",
          errors: errors,
          data: nil
        })
      end
 
      def halt_with_500
        env['rack.errors'].puts ex
        env['rack.errors'].puts ex.backtrace.join("\n")
        env['rack.errors'].flush
   
        hash = { :message => ex.to_s }
        hash[:backtrace] = ex.backtrace if ENV['RACK_ENV']['development']
   
        halt 500, json(MultiJson.dump(hash))
      end

      def halt_with_501(message = nil)
        message ||= 'Not Implemented'
        halt 501, json(message: message, data: nil)
      end
    end
 
    def self.registered(app)
      app.helpers ErrorHandling::Helpers

      app.not_found do
        halt_with_404
      end
 
      app.error ActiveRecord::RecordNotFound do
        halt_with_404
      end
 
      app.error ActiveRecord::RecordInvalid do
        halt_with_422
      end
 
      app.error ActiveRecord::UnknownAttributeError do
        halt_with_422
      end
 
      app.error ActiveRecord::DeleteRestrictionError do
        halt_with_400
      end
 
      app.error do
        # here is possible to hook some remote exception tracker
        # if ::Exceptional::Config.should_send_to_api?
        #   ::Exceptional::Remote.error(::Exceptional::ExceptionData.new(env['sinatra.error']))
        # end
        halt_with_500
      end
    end
 
  end
  
  register ErrorHandling
end
