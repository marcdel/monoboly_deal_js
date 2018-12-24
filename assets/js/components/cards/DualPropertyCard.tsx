import * as React from "react"
import {DualProperty} from "../../models/cards/DualProperty"

interface Props {
  card: DualProperty
}

export const DualPropertyCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      {card.properties.map((property, index) => <div className="capitalize" key={index}>{property.color} Property
        Card</div>)}
      <div>M{card.value}</div>
    </div>
  )
}
