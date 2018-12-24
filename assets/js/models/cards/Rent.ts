export class Rent {
  public colors: string[]
  public name: string
  public value: number

  constructor(params: Partial<Rent>) {
    this.colors = params.colors
    this.name = params.name
    this.value = params.value
  }
}
