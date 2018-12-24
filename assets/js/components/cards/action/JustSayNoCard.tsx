import * as React from "react"
import {JustSayNo} from "../../../models/cards/action/JustSayNo"

interface Props {
  card: JustSayNo
}

export const JustSayNoCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>Just Say No!</div>
      <div>M{card.value}</div>
    </div>
  )
}
