import { Controller } from "stimulus"
import I18n from "../i18n-js/index.js.erb"

export default class extends Controller {

  connect() {
    this.element.remove()
    if (this.data.get("type") === "notice") {
      iziToast.success({message: this.data.get("message"), title: I18n.t('iziToast.success'), position: "topRight"})
    } else if (this.data.get("type") === "alert") {
      iziToast.error({message: this.data.get("message"), title: I18n.t('iziToast.error'), position: "topRight"})
    } else {
      iziToast.info({message: this.data.get("message"), title: I18n.t('iziToast.info'), position: "topRight"})
    }
  }

}
