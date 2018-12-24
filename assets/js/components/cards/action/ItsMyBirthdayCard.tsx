import * as React from "react"
import {ItsMyBirthday} from "../../../models/cards/action/ItsMyBirthday"

interface Props {
  card: ItsMyBirthday
}

export const ItsMyBirthdayCard = (props: Props) => {
  const {card} = props
  return (
    <div className="card">
      <div>M{card.value}</div>
      <div>Action Card</div>
      <div>It's My Birthday!</div>
      <div>M{card.value}</div>
    </div>
  )
}
