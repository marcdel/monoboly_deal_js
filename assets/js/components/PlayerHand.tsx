import * as React from "react"
import {Card} from "../models/Card"
import {CardDisplay} from "./CardDisplay"

interface Props {
  cards: Card[]
}

export const PlayerHand = (props: Props) => {
  const {cards} = props

  return (
    <div className="hand-container">
      <h3>Cards</h3>
      <div className="hand">
        {cards.map((card: Card, index: number) => <CardDisplay card={card} key={index}/>)}
      </div>
    </div>
  )
}
