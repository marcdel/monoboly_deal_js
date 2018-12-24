export class Action {
  public name: string
  public type: string
  public value: number

  constructor(params: Partial<Action>) {
    this.name = params.name
    this.type = params.type
    this.value = params.value
  }
}
