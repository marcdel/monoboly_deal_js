import * as React from "react"
import {ForcedDeal} from "../../../models/cards/action/ForcedDeal"

interface Props {
  card: ForcedDeal
}

export const ForcedDealCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>Debt Collector</div>
      <div>M{card.value}</div>
    </div>
  )
}
