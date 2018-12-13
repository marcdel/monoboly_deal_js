import * as React from "react"
import {Player} from "../models/Player"
import {PlayersItem} from "./PlayerItem"

interface Props {
  players: Player[]
}

export const PlayersList = (props: Props) => {
  const {players} = props
  return (
    <div className="players-container">
      <h3>Players</h3>
      <ul>
        {players.map((player: Player, index: number) => <PlayersItem player={player} key={index}/>)}
      </ul>
    </div>
  )
}
