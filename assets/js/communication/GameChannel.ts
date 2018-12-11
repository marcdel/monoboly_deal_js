import {Channel, Socket} from "phoenix"
import {GameState} from "../models/GameState"
import {Player} from "../models/Player"

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

  public onGameStateUpdated(callBack: (gameState: GameState) => void) {
    this.channel.on("game_state", (response: any) => {
      if (response) {
        const gameState = new GameState({
          gameStarted: response.started,
          name: response.game_name,
          players: response.players.map((player: any) => new Player({name: player.name})),
        })

        callBack(gameState)
      }
    })
  }

  public onPlayerStateUpdated(callBack: (playerState: Player) => void) {
    this.channel.on("player_state", (response: any) => {
      if (response) {
        const player = new Player(response)
        callBack(player)
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
