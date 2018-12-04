let Game = {
  init(socket, element) {
    if(!element) { return }

    socket.connect()

    const gameName = element.getAttribute("data-name")
    const gameChannel = socket.channel("games:" + gameName)
    const dealButton = document.getElementById("deal-button")
    const handContainer = document.querySelector(".hand-container")

    dealButton.addEventListener("click", _event => {
      gameChannel
        .push("deal_hand")
        .receive("error", error => {
          console.log("deal_hand", {error})
        })
    })

    gameChannel.on("player_hand", (response) => {
      console.log("player_hand", {response})

      if(response.hand) {
        dealButton.style.visibility = 'hidden'
        this.renderHand(handContainer, response.hand)
      }
    })

    gameChannel
      .join()
      .receive("ok", response => {
        console.log("join", {response})
      })
      .receive("error", (reason) => {
        console.log("join failed", {reason})
      })
  },

  renderHand(handContainer, hand) {
    hand.forEach(card => handContainer.appendChild(this.renderCard(card)))
  },

  renderCard(card) {
    const cardContainer = document.createElement("div")
    cardContainer.setAttribute("class", "card")

    cardContainer.innerHTML = `
      (${card.value}) ${card.name}
    `

    return cardContainer
  }
}

export default Game
