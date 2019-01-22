import {Channel, Socket} from "phoenix"
import {GameState, GameStateError} from "../models/GameState"
import {Player} from "../models/Player"
import {PlayerSerializer} from "../serializers/PlayerSerializer"

type SuccessCallback = (response: any) => void
type ErrorCallback = (error: GameStateError) => void
type GameStateUpdatedCallback = (newGameState: GameState) => void
type PlayerStateUpdatedCallback = (newPlayerState: Player) => void

export class GameChannel {
  public channel: Channel
  private playerSerializer: PlayerSerializer

  constructor({
    gameName,
    socket,
    successCallback,
    errorCallback,
    gameStateUpdatedCallback,
    playerStateUpdatedCallback
  }: {
    gameName: string,
    socket: Socket,
    successCallback: SuccessCallback,
    errorCallback: ErrorCallback,
    gameStateUpdatedCallback: GameStateUpdatedCallback
    playerStateUpdatedCallback: PlayerStateUpdatedCallback
  }) {
    this.channel = socket.channel("games:" + gameName)
    this.playerSerializer = new PlayerSerializer()

    this.onGameStateUpdated(gameStateUpdatedCallback)
    this.onPlayerStateUpdated(playerStateUpdatedCallback)

    this.channel
      .join()
      .receive("ok", successCallback)
      .receive("error", errorCallback)
  }

  public dealHand() {
    this.channel
      .push("deal_hand", {})
      .receive("error", (error) => {
        console.log("deal_hand failed", {error})
      })
  }

  private onGameStateUpdated(callBack: (gameState: GameState) => void) {
    this.channel.on("game_state", (response: any) => {
      if (response) {
        const gameState = new GameState({
          gameStarted: response.started,
          name: response.game_name,
          players: response.players.map((player: any) => {
            return this.playerSerializer.deserialize(player)
          }),
        })

        callBack(gameState)
      }
    })
  }

  private onPlayerStateUpdated(callBack: (playerState: Player) => void) {
    this.channel.on("player_state", (response: any) => {
      if (response) {
        const player = this.playerSerializer.deserialize(response)
        callBack(player)
      }
    })
  }
}
