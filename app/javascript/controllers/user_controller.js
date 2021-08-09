import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "followButton" ]

  follow(event) {
    event.preventDefault()

    let userId = this.followButtonTarget.dataset.user

    axios.post(`/users/${userId}/follow`)
    .then(function (response) {
      console.log(response.data)
    })
    .catch(function (error) {
      console.log(error)
    })
  }
}
