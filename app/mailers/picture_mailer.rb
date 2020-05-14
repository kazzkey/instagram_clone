class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: "k_kawano86@yahoo.co.jp", subject: "画像投稿確認メール"
  end
end
