module UsersHelper
  ## 若使用方法時沒帶入參數，預設 250x250
  def avatar(user, size: 250)
    image_tag user.avatar.variant(resize: "#{size}x#{size}"), class: 'user-avatar' if user.avatar.attached?
  end

end
