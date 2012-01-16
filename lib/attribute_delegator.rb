require "attribute_delegator/version"

module AttributeDelegator
  extend ActiveSupport::Concern

  module ClassMethods

    private

    def delegates_attributes_to(the_delegate, attrs)

      exists_method = :"ensure_#{the_delegate}_exists"
      define_method exists_method do
        build_method = "build_#{the_delegate.to_s}"
        self.send(build_method.to_sym)
      end

      saved_method = :"ensure_#{the_delegate}_saved"
      define_method saved_method do
        delegate_obj = self.send(the_delegate)
        return unless delegate_obj
        if delegate_obj.changed? || delegate_obj.new_record?
          delegate_obj.save!
        end
      end

      # This would normally be an 'after_update' callback, but meta it cause the callback name changes
      self.send(:after_update, saved_method)

      attrs.each do |attr|
        # Define the getter
        define_method :"#{attr}" do
          delegate_obj = self.send(the_delegate)
          # Only send the attribute query if the object already
          # exists. If it hasn't been instantiated, just return nil
          if delegate_obj
            delegate_obj.send(attr)
          else
            nil
          end
        end

        #Define the setter
        define_method :"#{attr}=" do |arg|
          self.send(exists_method)
          self.send(the_delegate).send("#{attr}=".to_sym, arg)
        end
      end
    end
  end
end
