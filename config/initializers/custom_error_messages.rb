# FIXME This hack is only needed until this patch makes it into rails
# https://rails.lighthouseapp.com/projects/8994/tickets/3768-patch-add-full_message-option-to-validations

# Redefine ActiveModel::Errors#full_message
# original method: https://github.com/rails/rails/blob/master/activemodel/lib/active_model/errors.rb
#
#   Regular errors are handled as usual.  The only change is that for 
#   any non-base messages that is prefixed with '^', it will not get an attribute prefix.
#   E.g. validates :terms, :presence => true, :message => '^Please accept the terms of service'

class ActiveModel::Errors
  # redeclare this because lazy loading was causing the full_message monkey patch to be ignored
  def full_messages
    map { |attribute, message| full_message(attribute, message) }
  end
    
  def full_message(attribute, message)
    return message if attribute == :base
    if message.match(/\A\^/)
      message.gsub(/\A\^/, '')
    else
      attr_name = attribute.to_s.gsub('.', '_').humanize
      attr_name = @base.class.human_attribute_name(attribute, :default => attr_name)
      I18n.t(:"errors.format", {
        :default   => "%{attribute} %{message}",
        :attribute => attr_name,
        :message   => message
      })
    end
  end
end