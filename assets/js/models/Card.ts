export class Card {
  public name: string
  public value: number

  constructor(params: Partial<Card>) {
    this.name = params.name
    this.value = params.value
  }
}
