import {Channel, Socket} from "phoenix"
import {Card} from "../models/Card"

export class PlayerChannel {
  private channel: Channel

  constructor(playerName: string, socket: Socket) {
    this.channel = socket.channel("players:" + playerName)

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
        const cards = response.hand.map((card: object) => new Card(card))

        callBack(cards)
      }
    })
  }
}
