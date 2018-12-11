import {Card} from "./Card"

export class Player {
  public name: string
  public hand: Card[]

  constructor(params: Partial<Player> = {}) {
    this.name = params.name
    this.hand = params.hand || []
  }
}
