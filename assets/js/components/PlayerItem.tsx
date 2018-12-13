import * as React from "react"
import {Player} from "../models/Player"

interface Props {
  player: Player
}

export const PlayersItem = (props: Props) => {
  const {player} = props
  return (
    <li>
      {player.name}
    </li>
  )
}
