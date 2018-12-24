import * as React from "react"
import {Action} from "../../models/cards/action"

interface Props {
  card: Action
}

export const ActionCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">{card.value} {card.name}</div>
  )
}
