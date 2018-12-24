import * as React from "react"
import {Property} from "../../models/cards/Property"

interface Props {
  card: Property
}

export const PropertyCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div className="capitalize">{card.color} Property Card</div>
      {card.rentValues.map((value: number, index: number) => <div key={index}>{index + 1} - M{value}</div>)}
      <div>M{card.value}</div>
    </div>
  )
}
