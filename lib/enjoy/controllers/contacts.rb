module Enjoy
  module Controllers
    module Contacts
      extend ActiveSupport::Concern
      def index
        @contact_message = model.new
        after_initialize
        xhr_checker
      end

      def new
        @contact_message = model.new
        after_initialize
        xhr_checker
      end

      def create
        @contact_message = model.new(message_params)
        after_initialize
        if Enjoy.config.contacts_captcha
          meth = :save_with_captcha
        else
          meth = :save
        end
        if @contact_message.send(meth)
          after_create
          if request.xhr? && process_ajax
            ajax_success
          else
            redirect_after_done
          end
        else
          render_contacts_error
        end
      end

      def sent
      end

      private
      def render_contacts_error
        if request.xhr? && process_ajax
          render partial: form_partial
          # render json: {errors: @contact_message.errors}, status: 422
        else
          flash.now[:alert] = @contact_message.errors.full_messages.join("\n")
          render action: Enjoy.configuration.recreate_contact_message_action, status: 422
        end
      end
      def process_ajax
        true
      end
      def ajax_success
        render partial: success_partial
        # render json: {ok: true}
      end
      def redirect_after_done
        redirect_to :contacts_sent
      end
      def xhr_checker
        if request.xhr?
          render layout: false
        end
      end
      def after_initialize
      end
      def after_create
        # overrideable hook for updating message
      end
      def form_partial
        "enjoy/contacts/form"
      end
      def success_partial
        "enjoy/contacts/success"
      end
      def model
        Enjoy::ContactMessage
      end
      def message_params
        params.require(model.to_param.gsub("::", "").underscore).permit(
          Enjoy.config.contacts_fields.keys + [:name, :email, :phone, :content, :captcha, :captcha_key]
        )
      end
    end
  end
end
