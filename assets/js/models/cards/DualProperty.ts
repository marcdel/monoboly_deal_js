import {Property} from "./Property"

export class DualProperty {
  public name: string
  public properties: Property[]
  public value: number

  constructor(params: Partial<DualProperty>) {
    this.name = params.name
    this.properties = params.properties
    this.value = params.value
  }
}
