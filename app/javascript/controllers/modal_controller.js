import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
    const modal_inner = this.element.parentElement;
    modal_inner.parentElement.remove();
  }
}