import {Player} from "../models/Player"
import {CardSerializer} from "./CardSerializer"

interface PlayerJson {
  name: string
  hand: object[]
}

export class PlayerSerializer {
  public deserialize = (playerJson: PlayerJson) => {
    if (!playerJson) {
      return
    }

    return new Player({
      hand: playerJson.hand && playerJson.hand.map((cardJson: object) => {
        return new CardSerializer().deserialize(cardJson)
      }),
      name: playerJson.name,
    })
  }
}
