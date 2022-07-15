class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts = {})
    opts[:subject] = if !record.unconfirmed_email.nil?
                       '[Karibito]メールアドレス変更手続きを完了してください'
                     else
                       '[Karibito]会員登録完了'
                     end
    super
  end
end
