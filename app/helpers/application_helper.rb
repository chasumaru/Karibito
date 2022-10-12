module ApplicationHelper
  include Pagy::Frontend

  # タイトル用のメソッド
  def full_title(page_title = '')
    base_title = 'Karibito'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def avatar_link(item)
    if item.user.avatar.attached? 
      if item.user == current_user 
        link_to profile_path(current_user) do
          image_tag current_user.avatar, alt: 'アバター画像', class: 'w-8 h-8 rounded-full border-2 border-emerald-500 no-tap-highlighting'
        end
      else
        link_to profile_path(item.user) do
          image_tag item.user.avatar, alt: 'アバター画像', class: 'w-8 h-8 rounded-full border-2 border-indigo-500 no-tap-highlighting'
        end
      end 
    else 
      image_tag 'no_avatar.png', class: 'w-8 h-8 object-cover rounded-full border border-yellow-300 no-tap-highlighting' 
    end
  end

  # 時間間隔を表示
  def how_long_ago(object)
    if (Time.now - object.created_at) <= 60 * 60
      # 60分以内
      ((Time.now - object.created_at) / 60).to_i.to_s + '分前'
    elsif (Time.now - object.created_at) <= 60 * 60 * 24
      # 24時間以内
      ((Time.now - object.created_at) / 3600).to_i.to_s + '時間前'
    elsif (Date.today - object.created_at.to_date) <= 14
      # 14日以内
      (Date.today - object.created_at.to_date).to_i.to_s + '日前'
    else
      #それ以降
      object.created_at
    end
  end

  def turbo_stream_flash
    turbo_stream.update 'flash', partial: 'shared/flash'
  end

# # Omniaauth関連の設定
#   def devise_mapping
#     Devise.mappings[:user]
#   end
  
#   def resource_name
#     devise_mapping.name
#   end
  
#   def resource_class
#     devise_mapping.to
#   end
end
