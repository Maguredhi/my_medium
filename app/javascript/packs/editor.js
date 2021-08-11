import FroalaEditor from 'froala-editor'
import 'froala-editor/js/languages/zh_tw.js'
import 'froala-editor/js/plugins/table.min.js'
import 'froala-editor/js/plugins/colors.min.js'
import 'froala-editor/js/plugins/draggable.min.js'
import 'froala-editor/js/plugins/font_size.min.js'
import 'froala-editor/js/plugins/fullscreen.min.js'
import 'froala-editor/js/plugins/image.min.js'
import 'froala-editor/js/plugins/link.min.js'
import 'froala-editor/js/plugins/lists.min.js'
import 'froala-editor/js/plugins/quote.min.js'
import 'froala-editor/js/plugins/video.min.js'

// DOMContentLoaded 是一般 HTML 的監聽事件，這裡必須改用 turbolinks 去監聽
// 還是無效，改成在 link_to 去加 data: { turbolinks: false }
document.addEventListener('turbolinks:load', function (event) {
  let editor = new FroalaEditor('#story_content', {
    language: 'zh_tw',
    spellchekc: false,
    // 上傳照片到後端的某個地方
    imageUploadURL: '/api/upload_image'

  })
})
