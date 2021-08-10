import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "followButton" ]

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
}
