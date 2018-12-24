export class WildProperty {
  public name: string
  public value: number

  constructor(params: Partial<WildProperty>) {
    this.name = params.name
    this.value = params.value
  }
}
