# Add a callback - to be executed before each request in development,
# and at startup in production - to patch existing app classes.
# Doing so in init/environment.rb wouldn't work in development, since
# classes are reloaded, but initialization is not run each time.
# See http://stackoverflow.com/questions/7072758/plugin-not-reloading-in-development-mode
#
Rails.configuration.to_prepare do

  # Example of adding a default text to each message
  # OutgoingMessage.class_eval do
  #   # Add intro paragraph to new request template
  #   def default_letter
  #     return nil if self.message_type == 'followup'
  #     "If you uncomment this line, this text will appear as default text in every message"
  #   end
  # end

  # Based on alaveteli/app/models/incoming_message.rb, see
  # https://github.com/mysociety/alaveteli/issues/2662
  InfoRequest.class_eval do
    def self.remove_quoted_sections(text, replacement = "FOLDED_QUOTED_SECTION")
      text = text.dup
      replacement = "\n" + replacement + "\n"

      # To end of message sections
      original_message =
        '(' +
        # Used in https://www.mimesbronn.no/request/innsyn_i_arkivplan
        '''----*\s*Opprinnelig melding\s*----*''' +
        ')'
      # Could have a ^ at start here, but see messed up formatting here:
      # http://www.whatdotheyknow.com/request/refuse_and_recycling_collection#incoming-842
      text.gsub!(/(#{original_message}\n.*)$/mi, replacement)
      return text
    end
  end
end
