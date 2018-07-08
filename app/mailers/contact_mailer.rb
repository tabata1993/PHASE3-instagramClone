class ContactMailer < ApplicationMailer
  def contact_mail(blog,current_user)
    @blog = blog
    @current_user = current_user
    mail to: current_user.email, subject: "Secondgramに画像が投稿されました！"
  end
end
