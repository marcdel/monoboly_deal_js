import {Player} from "./Player"

export class GameState {
  public name: string
  public gameStarted: boolean
  public players: Player[]
  public currentPlayer: Player

  constructor(params: Partial<GameState> = {}) {
    this.name = params.name
    this.gameStarted = params.gameStarted
    this.players = params.players
    this.currentPlayer = params.currentPlayer
  }
}
