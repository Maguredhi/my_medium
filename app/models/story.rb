class Story < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  include AASM
  belongs_to :user
  validates :title, presence: true

  ## 預設撈出無軟刪除的 story
  default_scope { where(deleted_at: nil) }
  ## 複寫 destroy action 為軟刪除
  def destroy
    update(deleted_at: Time.now)
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

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  private
  ## 修改 URL 為 story title，若同名加上亂碼
  def slug_candidate
    [
      :title,
      [:title, SecureRandom.hex[0, 8]]
    ]
  end

end
