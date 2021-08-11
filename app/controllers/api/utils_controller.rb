# 設定好前端上傳檔案的路徑到什麼地方，在後端設定去接傳過來的這包東西
class Api::UtilsController < Api::BaseController
  # 建立上傳檔案格式白名單
  IMAGE_EXT = [".gif", ".jpeg", ".jpg", ".png", ".svg"]
  def upload_image
    f = params[:file]
    # ext副檔名，可用內建 file.extname 方法去檢查
    ext = File.extname(f.original_filename)
    raise 'Not allowed' unless IMAGE_EXT.include?(ext)

    # ActiveStorage 的 create_after_upload! 方法，可以抓外部傳來的檔案
    blob = ActiveStorage::Blob.create_after_upload!(
      # 接檔案
      io: f,
      # 接檔名
      filename: f.original_filename,
      # 接content_type
      content_type: f.content_type
    )
    # 使用 url_for 方法，確認 bolb 的路徑 
    render json: { link: url_for(blob) }

  end

end
