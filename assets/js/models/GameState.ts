import {Player} from "./Player"

type ErrorType = 'game_not_found' | 'game_started'

export interface GameStateError {
  error: ErrorType
  message: string
}

export class GameState {
  public name: string
  public gameStarted: boolean
  public players: Player[]
  public error: GameStateError | null

  constructor(params: Partial<GameState> = {}) {
    this.name = params.name
    this.gameStarted = params.gameStarted
    this.players = params.players
    this.error = params.error
  }
}
