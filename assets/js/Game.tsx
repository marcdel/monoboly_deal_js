import {Channel, Socket} from "phoenix"
import * as React from "react"

interface Props {
  gameName: string
  playerName: string
  socket: Socket
}

interface State {
  gameChannel: Channel | null
  hand: Card[]
  newGame: boolean
}

interface Card {
  name: string
  value: number
}

export class Game extends React.Component<Props, State> {
  constructor(props: Props, state: State) {
    super(props, state)

    this.state = {
      gameChannel: null,
      hand: [],
      newGame: true,
    }
  }

  public componentDidMount() {
    this.props.socket.connect()
    this.initializeGameChannel()
    this.initializePlayerChannel()
  }

  public render() {
    const {gameName} = this.props
    const {newGame} = this.state

    return (
      <>
        <h1>{gameName}</h1>
        {newGame && <button onClick={this.dealHand} className="button">Deal</button>}
        {this.renderHand()}
      </>
    )
  }

  private initializePlayerChannel() {
    const playerChannel = this.props.socket.channel("players:" + this.props.playerName)

    playerChannel
      .join()
      .receive("ok", (response) => {
        console.log("player channel joined", {response})
      })
      .receive("error", (reason) => {
        console.log("player channel join failed", {reason})
      })

    playerChannel.on("player_hand", (response) => {
      if (response.hand) {
        this.setState({newGame: false, hand: response.hand})
      }
    })
  }

  private initializeGameChannel() {
    const gameChannel = this.props.socket.channel("games:" + this.props.gameName)
    this.setState({gameChannel})

    gameChannel
      .join()
      .receive("ok", (response) => {
        console.log("game channel joined", {response})
      })
      .receive("error", (reason) => {
        console.log("game channel join failed", {reason})
      })

    gameChannel.on("player_hand", (response) => {
      if (response.hand) {
        this.setState({newGame: false, hand: response.hand})
      }
    })
  }

  private dealHand = () => {
    this.state.gameChannel
      .push("deal_hand", {})
      .receive("error", (error) => {
        console.log("deal_hand", {error})
      })
  }

  private renderHand = () => {
    return this.state.hand.map(this.renderCard)
  }

  private renderCard = (card: Card, index: number) => {
    return (
      <div key={index}>{card.value} {card.name}</div>
    )
  }
}
