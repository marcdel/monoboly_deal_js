import "phoenix_html"
// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"

import * as React from "react"
import {render} from "react-dom"
import socket from "./communication/socket"
import {Game} from "./components/Game"

const gameDiv = document.getElementById("game")
if (gameDiv) {
  const gameName = gameDiv.getAttribute("data-game")
  const playerName = gameDiv.getAttribute("data-player")
  render(<Game gameName={gameName} playerName={playerName} socket={socket}/>, gameDiv)
}
