export class Property {
  public color: string
  public name: string
  public rentValues: number[]
  public value: number

  constructor(params: Partial<Property>) {
    this.color = params.color
    this.name = params.name
    this.rentValues = params.rentValues
    this.value = params.value
  }
}
