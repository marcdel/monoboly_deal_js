import {Socket} from "phoenix"
import * as React from "react"
import {GameChannel} from "../communication/GameChannel"
import {GamePresence} from "../communication/GamePresence"
import {PlayerChannel} from "../communication/PlayerChannel"
import {createPresence} from "../communication/presenceHelper"
import {PlayersList} from "../components/PlayersList"
import {Card} from "../models/Card"
import {GameState, GameStateError} from "../models/GameState"
import {Player} from "../models/Player"
import {PlayerHand} from "./PlayerHand"

interface Props {
  gameName: string
  playerName: string
  socket: Socket
}

interface State {
  currentPlayer: Player
  gameChannel: GameChannel | null
  gameState: GameState
  playerChannel: PlayerChannel | null
  presentPlayers: Player[]
}

export class Game extends React.Component<Props, State> {
  constructor(props: Props, state: State) {
    super(props, state)

    const gameState = new GameState({
      gameStarted: false,
      name: this.props.gameName,
      players: [],
      error: null,
    })

    this.state = {
      currentPlayer: new Player({name: this.props.playerName}),
      gameChannel: null,
      gameState,
      playerChannel: null,
      presentPlayers: [],
    }
  }

  public componentDidMount() {
    const {socket, gameName, playerName} = this.props

    socket.connect()

    const playerChannel = new PlayerChannel(playerName, socket)
    playerChannel.onHandUpdated(this.onHandUpdated)

    const gameChannel = new GameChannel({
      gameName,
      socket,
      successCallback: this.onGameChannelJoined,
      errorCallback: this.onGameChannelJoinFailed,
      gameStateUpdatedCallback: this.onGameStateUpdated,
      playerStateUpdatedCallback: this.onPlayerStateUpdated,
    })

    const gamePresence = new GamePresence(
      createPresence(gameChannel.channel),
      this.onPlayersUpdated,
    )

    this.setState({playerChannel, gameChannel})
  }

  public render() {
    const {currentPlayer, gameState} = this.state

    if(gameState.error) {
      return <h3>{gameState.error.message}</h3>
    }

    return (
      <div className="game-container">
        {this.renderDealButton(gameState)}
        {gameState.gameStarted && <PlayerHand cards={currentPlayer.hand}/>}
        <PlayersList players={gameState.players}/>
      </div>
    )
  }

  private renderDealButton(gameState: GameState) {
    if (gameState.gameStarted || gameState.error) {
      return null
    }

    return (
      <button onClick={this.dealHand} className="button">
        Deal
      </button>
    )
  }

  private dealHand = (): void => {
    this.state.gameChannel.dealHand()
  }

  private onHandUpdated = (cards: Card[]): void => {
    const currentPlayer = {...this.state.currentPlayer}
    currentPlayer.hand = cards

    this.setState({currentPlayer})
  }

  private onGameChannelJoined = (response: any) => {
    console.log("game channel joined", {response})
  }

  private onGameChannelJoinFailed = (error: GameStateError) => {
    console.log("game channel join failed", {error})
    this.setState({gameState: {...this.state.gameState, error}})
  }

  private onGameStateUpdated = (newGameState: GameState) => {
    this.setState({gameState: {...this.state.gameState, ...newGameState}})
  }

  private onPlayerStateUpdated = (newPlayerState: Player) => {
    this.setState({currentPlayer: newPlayerState})
  }

  private onPlayersUpdated = (players: Player[]): void => {
    this.setState({presentPlayers: players})
  }
}
