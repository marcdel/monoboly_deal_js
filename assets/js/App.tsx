import "phoenix_html"
import socket from "./socket"

import * as React from "react"
import {render} from "react-dom"
import {Game} from "./Game"

const gameDiv = document.getElementById("game")
if (gameDiv) {
  const gameName = gameDiv.getAttribute("data-game")
  const playerName = gameDiv.getAttribute("data-player")
  render(<Game gameName={gameName} playerName={playerName} socket={socket}/>, gameDiv)
}
