import * as React from "react"
import {Card} from "../models/Card"
import {DealBreaker} from "../models/cards/action/DealBreaker"
import {DebtCollector} from "../models/cards/action/DebtCollector"
import {DoubleTheRent} from "../models/cards/action/DoubleTheRent"
import {ForcedDeal} from "../models/cards/action/ForcedDeal"
import {Hotel} from "../models/cards/action/Hotel"
import {House} from "../models/cards/action/House"
import {ItsMyBirthday} from "../models/cards/action/ItsMyBirthday"
import {JustSayNo} from "../models/cards/action/JustSayNo"
import {PassGo} from "../models/cards/action/PassGo"
import {SlyDeal} from "../models/cards/action/SlyDeal"
import {DualProperty} from "../models/cards/DualProperty"
import {Money} from "../models/cards/Money"
import {Property} from "../models/cards/Property"
import {Rent} from "../models/cards/Rent"
import {WildProperty} from "../models/cards/WildProperty"
import {CardComponentFactory} from "./CardComponentFactory"
import {DealBreakerCard} from "./cards/action/DealBreakerCard"
import {DebtCollectorCard} from "./cards/action/DebtCollectorCard"
import {DoubleTheRentCard} from "./cards/action/DoubleTheRentCard"
import {ForcedDealCard} from "./cards/action/ForcedDealCard"
import {HotelCard} from "./cards/action/HotelCard"
import {HouseCard} from "./cards/action/HouseCard"
import {ItsMyBirthdayCard} from "./cards/action/ItsMyBirthdayCard"
import {JustSayNoCard} from "./cards/action/JustSayNoCard"
import {PassGoCard} from "./cards/action/PassGoCard"
import {SlyDealCard} from "./cards/action/SlyDealCard"
import {DualPropertyCard} from "./cards/DualPropertyCard"
import {MoneyCard} from "./cards/MoneyCard"
import {PropertyCard} from "./cards/PropertyCard"
import {PropertyWildCard} from "./cards/PropertyWildCard"
import {RentCard} from "./cards/RentCard"

interface Props {
  card: Card
}

export const CardDisplay = (props: Props) => {
  const {card} = props

  // TODO: do this elsewhere
  const cardComponentFactory = new CardComponentFactory()
  cardComponentFactory.register(DealBreaker, DealBreakerCard)
  cardComponentFactory.register(DebtCollector, DebtCollectorCard)
  cardComponentFactory.register(DoubleTheRent, DoubleTheRentCard)
  cardComponentFactory.register(ForcedDeal, ForcedDealCard)
  cardComponentFactory.register(Hotel, HotelCard)
  cardComponentFactory.register(House, HouseCard)
  cardComponentFactory.register(ItsMyBirthday, ItsMyBirthdayCard)
  cardComponentFactory.register(JustSayNo, JustSayNoCard)
  cardComponentFactory.register(PassGo, PassGoCard)
  cardComponentFactory.register(SlyDeal, SlyDealCard)
  cardComponentFactory.register(DualProperty, DualPropertyCard)
  cardComponentFactory.register(WildProperty, PropertyWildCard)
  cardComponentFactory.register(Money, MoneyCard)
  cardComponentFactory.register(Property, PropertyCard)
  cardComponentFactory.register(Rent, RentCard)

  const component = cardComponentFactory.buildComponent(card, props)

  return component ||
    <div className="card">{card.value} {card.name}</div>
}
