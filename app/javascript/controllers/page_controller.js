import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "clapCount", "followButton", "bookmark" ]

  addClap(event) {
    // 讓原本預設的行為停下來 （初始化）
    event.preventDefault()

    let slug = event.currentTarget.dataset.slug
    let target = this.clapCountTarget
    // /stories/:id/clap
    // JS用反斜線``將$包起來可在裡面用變數
    axios.post(`/api/stories/${slug}/clap`)
         .then(function (response) {
           let status = response.data.status
           console.log(response.data)
           switch (status) {
             case "sign_in_first":
               alert('必須先登入');
               break;
             default:
               target.innerHTML = status
           }
         })
         .catch(function (error) {
           console.log(error)
         })
       // this.clapCountTarget.innerHTML = 'test'
  }

  follow(event) {
    event.preventDefault()

    let userId = this.followButtonTarget.dataset.user
    let button = this.followButtonTarget

    axios.post(`/api/users/${userId}/follow`)
         .then(function (response) {
           let status = response.data.status
           switch (status) {
             case 'sign_in_first':
               alert('必須先登入')
               break;
             default:
               button.innerHTML = status
               break;
           }
           console.log(response.data)
         })
         .catch(function (error) {
           console.log(error)
         })
  }

  bookmark(event){
    event.preventDefault()

    let link = event.currentTarget
    let slug = link.dataset.slug
    let icon = this.bookmarkTarget

    axios.post(`/api/stories/${slug}/bookmark`)
         .then(function (response) {
           switch (response.data.status) {
             case 'Bookmarked':
               // fontawesome icon class
               icon.classList.add('fas')
               icon.classList.remove('far')
               break;
             case 'Unbookmark':
               icon.classList.add('far')
               icon.classList.remove('fas')
               break;
           }
           console.log(response.data)
         })
         .catch(function (error) {
           console.log(link)
           console.log(slug)
           console.log(error)
         })
  }
}
