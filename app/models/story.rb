class Story < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  include AASM

  # validations 驗證
  validates :title, presence: true

  # relationships 關聯
  belongs_to :user
  has_one_attached :cover_image

  # scopes 查詢範圍
  # 預設撈出沒有軟刪除的 story
  default_scope { where(deleted_at: nil) }
  # 避免 N+1 問題用 includes 方法，rails 會改用 SQL 的 IN 方法去查詢
  # 避免圖片 N+1 問題 Active Storage 提供 with_attached_name 方法
  scope :published_stories, -> { published.with_attached_cover_image.order(created_at: :desc).includes(:user) }

  # instance methods 實體方法
  # 複寫 destroy action 為軟刪除
  def destroy
    update(deleted_at: Time.now)
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  aasm(column: 'status', no_direct_assignment: true) do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  private
  # 修改 URL 為 story title，若同名加上亂碼
  def slug_candidate
    [
      :title,
      [:title, SecureRandom.hex[0, 8]]
    ]
  end

end
