import * as React from "react"
import {Hotel} from "../../../models/cards/action/Hotel"

interface Props {
  card: Hotel
}

export const HotelCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>Hotel</div>
      <div>M{card.value}</div>
    </div>
  )
}
