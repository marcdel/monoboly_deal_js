import "phoenix_html"
import css from "../css/app.css"
import socket from "./socket"

import * as React from "react"
import * as ReactDOM from "react-dom"
import { Game } from "./Game"

if (document.getElementById("game-root")) {
  const gameDiv = document.getElementById("game")
  const gameName = gameDiv && gameDiv.getAttribute("data-name")
  ReactDOM.render(<Game gameName={gameName} socket={socket} />,
    document.getElementById("game-root"))
}
