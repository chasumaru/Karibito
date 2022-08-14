module ApplicationHelper
  include Pagy::Frontend

  def how_long_ago(object)
    if (Time.now - object.created_at) <= 60 * 60
      # 60分以内
      ((Time.now - object.created_at) / 60).to_i.to_s + "分前"
    elsif (Time.now - object.created_at) <= 60 * 60 * 24
      # 24時間以内
      ((Time.now - object.created_at) / 3600).to_i.to_s + "時間前"
    elsif (Date.today - object.created_at.to_date) <= 14
      # 14日以内
      (Date.today - object.created_at.to_date).to_i.to_s + "日前"
    else
      #それ以降
      object.created_at
    end
  end
end
