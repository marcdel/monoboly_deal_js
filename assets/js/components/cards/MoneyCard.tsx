import * as React from "react"
import {Money} from "../../models/cards/Money"

interface Props {
  card: Money
}

export const MoneyCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>M{card.value}</div>
      <div>M{card.value}</div>
    </div>
  )
}
