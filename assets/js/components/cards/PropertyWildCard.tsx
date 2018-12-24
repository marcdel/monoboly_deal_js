import * as React from "react"
import {WildProperty} from "../../models/cards/WildProperty"

interface Props {
  card: WildProperty
}

export const PropertyWildCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Property Wild Card</div>
      <div>M{card.value}</div>
    </div>
  )
}
