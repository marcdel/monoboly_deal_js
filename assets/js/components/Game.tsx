import {Channel, Presence, Socket} from "phoenix"
import * as React from "react"
import {GameChannel} from "../communication/GameChannel"
import {GamePresence} from "../communication/GamePresence"
import {PlayerChannel} from "../communication/PlayerChannel"
import {createPresence} from "../communication/presenceHelper"
import {Card} from "../models/Card"
import {GameState} from "../models/GameState"
import {Player} from "../models/Player"

interface Props {
  gameName: string
  playerName: string
  socket: Socket
}

interface State {
  gameChannel: GameChannel | null
  gameState: GameState
  playerChannel: PlayerChannel | null
}

export class Game extends React.Component<Props, State> {
  constructor(props: Props, state: State) {
    super(props, state)

    const gameState = new GameState({
      currentPlayer: new Player(this.props.playerName),
      gameStarted: false,
      name: this.props.gameName,
    })

    this.state = {
      gameChannel: null,
      gameState,
      playerChannel: null,
    }
  }

  public componentDidMount() {
    const {socket, gameName, playerName} = this.props

    socket.connect()

    const playerChannel = new PlayerChannel(playerName, socket)
    playerChannel.onHandUpdated(this.onHandUpdated)

    const gameChannel = new GameChannel(gameName, socket)
    gameChannel.onHandUpdated(this.onHandUpdated)

    const gamePresence = new GamePresence(
      createPresence(gameChannel.channel),
      this.onPlayersUpdated,
    )

    this.setState({playerChannel, gameChannel})
  }

  public render() {
    const {gameState} = this.state

    return (
      <>
        <h1>{gameState.name}</h1>
        {this.renderDealButton(gameState)}
        {this.renderHand()}
      </>
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
    const {gameState} = this.state
    return gameState.currentPlayer.hand.map(this.renderCard)
  }

  private renderCard = (card: Card, index: number) => {
    return (
      <div key={index}>{card.value} {card.name}</div>
    )
  }

  private dealHand = (): void => {
    this.state.gameChannel.dealHand()
  }

  private onHandUpdated = (cards: Card[]): void => {
    const gameState = {...this.state.gameState}
    gameState.gameStarted = true
    gameState.currentPlayer.hand = cards

    this.setState({gameState})
  }

  private onPlayersUpdated = (players: Player[]): void => {
    const gameState = {...this.state.gameState}
    gameState.players = players

    this.setState({gameState})
  }
}
