import {Channel, Socket} from "phoenix"
import {Card} from "../models/Card"

export class GameChannel {
  public channel: Channel

  constructor(gameName: string, socket: Socket) {
    this.channel = socket.channel("games:" + gameName)

    this.channel
      .join()
      .receive("ok", (response: any) => {
        console.log("game channel joined", {response})
      })
      .receive("error", (reason: any) => {
        console.log("game channel join failed", {reason})
      })
  }

  public onHandUpdated(callBack: (hand: Card[]) => void) {
    this.channel.on("player_hand", (response: { hand: object[] }) => {
      if (response && response.hand) {
        const cards = response.hand.map((card: object) => new Card(card))

        callBack(cards)
      }
    })
  }

  public dealHand() {
    this.channel
      .push("deal_hand", {})
      .receive("error", (error) => {
        console.log("deal_hand failed", {error})
      })
  }
}
