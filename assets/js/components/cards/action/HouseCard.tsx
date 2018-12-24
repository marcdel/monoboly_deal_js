import * as React from "react"
import {House} from "../../../models/cards/action/House"

interface Props {
  card: House
}

export const HouseCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>House</div>
      <div>M{card.value}</div>
    </div>
  )
}
