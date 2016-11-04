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

      # First do this peculiar form of quoting, as the > single line quoting
      # further below messes with it. Note the carriage return where it wraps -
      # this can happen anywhere according to length of the name/email. e.g.
      # >>> D K Elwell <[email address]> 17/03/2008
      # 01:51:50 >>>
      # http://www.whatdotheyknow.com/request/71/response/108
      # http://www.whatdotheyknow.com/request/police_powers_to_inform_car_insu
      # http://www.whatdotheyknow.com/request/secured_convictions_aided_by_cct
      multiline_original_message = '(' + '''>>>.* \d\d/\d\d/\d\d\d\d\s+\d\d:\d\d(?::\d\d)?\s*>>>''' + ')'
      text.gsub!(/^(#{multiline_original_message}\n.*)$/m, replacement)

      # On Thu, Nov 28, 2013 at 9:08 AM, A User
      # <[1]request-7-skm40s2ls@xxx.xxxx> wrote:
      text.gsub!(/^( On [^\n]+\n\s*\<[^>\n]+\> (wrote|said):\s*\n.*)$/m, replacement)

      # Single line sections
      text.gsub!(/^(>.*\n)/, replacement)
      text.gsub!(/^(On .+ (wrote|said):\n)/, replacement)

      ['-', '_', '*', '#'].each do |scorechar|
        score = /(?:[#{scorechar}]\s*){8,}/
        text.sub!(/(Disclaimer\s+)?  # appears just before
                        (
                            \s*#{score}\n(?:(?!#{score}\n).)*? # top line
                            (disclaimer:\n|confidential|received\sthis\semail\sin\serror|virus|intended\s+recipient|monitored\s+centrally|intended\s+(for\s+|only\s+for\s+use\s+by\s+)the\s+addressee|routinely\s+monitored|MessageLabs|unauthorised\s+use)
                            .*?(?:#{score}|\z) # bottom line OR end of whole string (for ones with no terminator TODO: risky)
                        )
                       /imx, replacement)
      end

      # Special paragraphs
      # http://www.whatdotheyknow.com/request/identity_card_scheme_expenditure
      text.gsub!(/^[^\n]+Government\s+Secure\s+Intranet\s+virus\s+scanning
                    .*?
                    virus\sfree\.
                    /imx, replacement)
      text.gsub!(/^Communications\s+via\s+the\s+GSi\s+
                    .*?
                    legal\spurposes\.
                    /imx, replacement)
      # http://www.whatdotheyknow.com/request/net_promoter_value_scores_for_bb
      text.gsub!(/^http:\/\/www.bbc.co.uk
                    .*?
                    Further\s+communication\s+will\s+signify\s+your\s+consent\s+to\s+this\.
                    /imx, replacement)


      # To end of message sections
      # http://www.whatdotheyknow.com/request/123/response/192
      # http://www.whatdotheyknow.com/request/235/response/513
      # http://www.whatdotheyknow.com/request/445/response/743
      original_message =
        '(' + '''----* This is a copy of the message, including all the headers. ----*''' +
        '|' + '''----*\s*Original Message\s*----*''' +
        '|' + '''----*\s*Forwarded message.+----*''' +
        '|' + '''----*\s*Forwarded by.+----*''' +
        ')'
      # Could have a ^ at start here, but see messed up formatting here:
      # http://www.whatdotheyknow.com/request/refuse_and_recycling_collection#incoming-842
      text.gsub!(/(#{original_message}\n.*)$/mi, replacement)

      # Some silly Microsoft XML gets into parts marked as plain text.
      # e.g. http://www.whatdotheyknow.com/request/are_traffic_wardens_paid_commiss#incoming-401
      # Don't replace with "replacement" as it's pretty messy
      text.gsub!(/<\?xml:namespace[^>]*\/>/, " ")

      return text
    end
  end
end
