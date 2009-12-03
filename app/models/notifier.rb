class Notifier < ActionMailer::Base
  default_url_options[:host] = "referencebin.com"

  def verification_instructions(user)
    subject "prb - Email Verification"
    from    "sysadmin@referencebin.com"

    recipients user.email
    # Email body substitutions go here
    #body :user=> user

    content_type    "multipart/alternative"

    part "text/plain" do |p|
        p.body = render_message("verification_instructions_plain", :user => user, :verification_url => url_for(:controller => 'user_sessions', 
          :action => 'verify', :id => user.perishable_token))
        p.transfer_encoding = "base64"
    end

    part :content_type => "text/html", :body => render_message("verification_instructions_html", :user => user, :id => user.perishable_token)
  end
end
