import * as React from "react"
import {DebtCollector} from "../../../models/cards/action/DebtCollector"

interface Props {
  card: DebtCollector
}

export const DebtCollectorCard = (props: Props) => {
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
