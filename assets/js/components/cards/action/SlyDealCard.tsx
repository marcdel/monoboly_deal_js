import * as React from "react"
import {SlyDeal} from "../../../models/cards/action/SlyDeal"

interface Props {
  card: SlyDeal
}

export const SlyDealCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>Sly Deal</div>
      <div>M{card.value}</div>
    </div>
  )
}
