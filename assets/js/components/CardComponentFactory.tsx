import * as React from "react"
import {Card} from "../models/Card"

interface ComponentTypeMap {
  type: Card
  component: React.FunctionComponent
}

export class CardComponentFactory {
  private componentTypeMap: ComponentTypeMap[]

  constructor() {
    this.componentTypeMap = []
  }

  public register(type: any, component: any) {
    this.componentTypeMap.push({type, component})
  }

  public buildComponent(card: Card, props: any) {
    const item = this.componentTypeMap.find((map: ComponentTypeMap) => {
      return card.constructor.name === map.type.name
    })

    if (!item) {
      console.log("Couldn't find card", {card, props})

      return
    }

    const Component: React.FunctionComponent = item.component

    return <Component {...props} />
  }
}
