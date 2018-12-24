import {Action} from "../models/cards/action"
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

type ActionCardType =
  "deal_breaker" |
  "just_say_no" |
  "pass_go" |
  "forced_deal" |
  "sly_deal" |
  "debt_collector" |
  "its_my_birthday" |
  "double_the_rent" |
  "house" |
  "hotel"

export class CardSerializer {
  public deserialize = (cardJson: any) => {
    if (!cardJson) {
      throw new Error("You got dealt a card we didn't understand")
    }

    switch (cardJson.name) {
      case "action_card":
        return this.actionCardType(cardJson.type, {
          name: cardJson.name,
          type: cardJson.type,
          value: cardJson.value,
        })
      case "dual_property_card":
        return new DualProperty({
          name: cardJson.name,
          properties: cardJson.properties,
          value: cardJson.value,
        })
      case "money_card":
        return new Money({
          name: cardJson.name,
          value: cardJson.value,
        })
      case "property_card":
        return new Property({
          color: cardJson.color,
          name: cardJson.name,
          rentValues: cardJson.rent_values,
          value: cardJson.value,
        })
      case "property_wild_card":
        return new WildProperty({
          name: cardJson.name,
          value: cardJson.value,
        })
      case "rent_card":
        return new Rent({
          colors: cardJson.colors,
          name: cardJson.name,
          value: cardJson.value,
        })
      default:
        throw new Error(`What kind of card is this?! ${cardJson}`)
    }
  }

  private actionCardType(type: ActionCardType, params: Partial<Action>) {
    switch (type) {
      case "deal_breaker":
        return new DealBreaker(params)
      case "just_say_no":
        return new JustSayNo(params)
      case "pass_go":
        return new PassGo(params)
      case "forced_deal":
        return new ForcedDeal(params)
      case "sly_deal":
        return new SlyDeal(params)
      case "debt_collector":
        return new DebtCollector(params)
      case "its_my_birthday":
        return new ItsMyBirthday(params)
      case "double_the_rent":
        return new DoubleTheRent(params)
      case "house":
        return new House(params)
      case "hotel":
        return new Hotel(params)
    }
  }
}
