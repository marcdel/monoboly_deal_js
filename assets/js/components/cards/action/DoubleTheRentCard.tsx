import * as React from "react"
import {DoubleTheRent} from "../../../models/cards/action/DoubleTheRent"

interface Props {
  card: DoubleTheRent
}

export const DoubleTheRentCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>Double The Rent!</div>
      <div>M{card.value}</div>
    </div>
  )
}
