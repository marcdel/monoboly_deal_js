import * as React from "react"
import {DealBreaker} from "../../../models/cards/action/DealBreaker"

interface Props {
  card: DealBreaker
}

export const DealBreakerCard = (props: Props) => {
  const {card} = props
  // return <img className="card" src="/images/cards/action-card-deal-breaker.png"/>
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>Deal Breaker</div>
      <div>M{card.value}</div>
    </div>
  )
}
