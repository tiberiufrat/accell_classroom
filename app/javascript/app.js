import { onDocumentReady } from "helpers"
import I18n from "./i18n-js/index.js.erb"

class App {

  bindDomContentLoaded() {
    onDocumentReady(() => { this.bindFormAjaxError() })
  }

  bindTurboLinksEvents() {
    document.addEventListener("turbolinks:load", () => {
      //Initialize plugins here
    })
    document.addEventListener("turbolinks:before-cache", () => {
      //Destroy plugins here
    })
  }

// Private
  bindFormAjaxError() {
    document.addEventListener("ajax:error", (e) => {
      if (e.target.matches("[data-remote='true']")) {
        iziToast.error({message: I18n.t('iziToast.oops_error'), title: I18n.t('iziToast.error'), position: "topRight"})
      }
    })
  }
}

export function start() {
  const app = new App()
  app.bindDomContentLoaded()
  app.bindTurboLinksEvents()
}
