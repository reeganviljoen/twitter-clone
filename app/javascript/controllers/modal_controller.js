import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
    const modal = document.getElementsByClassName("modal");
    modal.remove
    Turbo.visit('/')
  }
}