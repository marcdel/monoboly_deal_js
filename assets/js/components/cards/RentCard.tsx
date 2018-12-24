import * as React from "react"
import {Rent} from "../../models/cards/Rent"

interface Props {
  card: Rent
}

export const RentCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      {card.colors.map((color: string, index: number) => <div className="capitalize" key={index}>{color}</div>)}
      <div>M{card.value}</div>
    </div>
  )
}
