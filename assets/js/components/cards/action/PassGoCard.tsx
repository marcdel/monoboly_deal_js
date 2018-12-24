import * as React from "react"
import {PassGo} from "../../../models/cards/action/PassGo"

interface Props {
  card: PassGo
}

export const PassGoCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>PassGo</div>
      <div>M{card.value}</div>
    </div>
  )
}
