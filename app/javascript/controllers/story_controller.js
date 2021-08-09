import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "clapCount" ]

  addClap(event) {
    // 讓原本預設的行為停下來 （初始化）
    event.preventDefault()

    let slug = event.currentTarget.dataset.slug
    let target = this.clapCountTarget
    // /stories/:id/clap
    // JS用反斜線``包起來可在裡面用變數
    axios.post(`/stories/${slug}/clap`)
    .then(function (response) {
      let status = response.data.status
      console.log(response)
      console.log(response.data)
      console.log(status)
      switch (status) {
        case "sign_in_first":
          alert('必須先登入');
          break;
        default:
          target.innerHTML = status
      }
      console.log(response)
    })
    .catch(function (error) {
      console.log(error)
    })
    // this.clapCountTarget.innerHTML = 'test'
  }
}
