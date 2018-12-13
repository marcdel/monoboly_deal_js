import {Channel, Presence, Socket} from "phoenix"
import * as React from "react"
import {GameChannel} from "../communication/GameChannel"
import {GamePresence} from "../communication/GamePresence"
import {PlayerChannel} from "../communication/PlayerChannel"
import {createPresence} from "../communication/presenceHelper"
import {PlayersList} from "../components/PlayersList"
import {Card} from "../models/Card"
import {GameState} from "../models/GameState"
import {Player} from "../models/Player"

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

    const gameChannel = new GameChannel(gameName, socket)
    gameChannel.onGameStateUpdated(this.onGameStateUpdated)
    gameChannel.onPlayerStateUpdated(this.onPlayerStateUpdated)

    const gamePresence = new GamePresence(
      createPresence(gameChannel.channel),
      this.onPlayersUpdated,
    )

    this.setState({playerChannel, gameChannel})
  }

  public render() {
    const {gameState} = this.state

    return (
      <div className="game-container">
        <div className="hand-container">
          {this.renderDealButton(gameState)}
          {this.renderHand()}
        </div>
        <PlayersList players={gameState.players}/>
      </div>
    )
  }

  private renderDealButton(gameState: GameState) {
    if (gameState.gameStarted) {
      return null
    }

    return (
      <button onClick={this.dealHand} className="button">
        Deal
      </button>
    )
  }

  private renderHand = () => {
    const {currentPlayer, gameState} = this.state

    if (!gameState.gameStarted) {
      return
    }

    return (
      <>
        <h3>Cards</h3>
        <ul>
          {currentPlayer.hand.map(this.renderCard)}
        </ul>
      </>
    )
  }

  private renderCard = (card: Card, index: number) => {
    return (
      <li key={index}>{card.value} {card.name}</li>
    )
  }

  private renderPlayer = (player: Player, index: number) => {
    return (
      <li key={index}>{player.name}</li>
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
