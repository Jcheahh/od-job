module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |_e|
      render file: "public/404.html", status: :not_found
    end

    # rescue_from ActiveRecord::RecordInvalid do |_e|
    #   render file: "public/422.html", status: :unprocessable_entity
    # end
  end
end
