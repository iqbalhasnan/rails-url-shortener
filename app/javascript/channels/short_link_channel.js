import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ShortLinkChannel" }, {
  received(data) {
    this.updateTitle(data)
  },

  updateTitle(data) {
    const titleElement = document.querySelector(`#${data.slug} .title`)
    titleElement.outerHTML = this.createLine(data)
  },

  createLine(data) {
    return `
      <p class="text-sm font-medium text-gray-500 truncate title">${data.title}</p>
    `
  }
})