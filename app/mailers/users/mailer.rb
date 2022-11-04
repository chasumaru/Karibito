class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts = {})
    opts[:subject] = if !record.unconfirmed_email.nil?
                       '[Karibito公式]メールアドレスの変更手続きメール'
                     else
                       '[Karibito公式]登録認証メール。'
                     end
    super
  end
end
