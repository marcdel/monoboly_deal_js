export class Money {
  public name: string
  public value: number

  constructor(params: Partial<Money>) {
    this.name = params.name
    this.value = params.value
  }
}
