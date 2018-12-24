import {Channel, Socket} from "phoenix"
import {Card} from "../models/Card"
import {CardSerializer} from "../serializers/CardSerializer"

export class PlayerChannel {
  private channel: Channel
  private cardSerializer: CardSerializer

  constructor(playerName: string, socket: Socket) {
    this.channel = socket.channel("players:" + playerName)
    this.cardSerializer = new CardSerializer()

    this.channel
      .join()
      .receive("ok", (response: any) => {
        console.log("player channel joined", {response})
      })
      .receive("error", (reason: any) => {
        console.log("player channel join failed", {reason})
      })
  }

  public onHandUpdated(callBack: (hand: Card[]) => void) {
    this.channel.on("player_hand", (response: { hand: object[] }) => {
      if (response && response.hand) {
        const cards = response.hand.map((cardJson: object) => {
          return this.cardSerializer.deserialize(cardJson)
        })

        callBack(cards)
      }
    })
  }
}
