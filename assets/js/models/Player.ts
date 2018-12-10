import {Card} from "./Card"

export class Player {
  public name: string
  public hand: Card[]

  constructor(name: string) {
    this.name = name
    this.hand = []
  }
}
