import {Player} from "../models/Player"

interface PlayerPresence {
  metas: object[]
}

export class GamePresence {
  private readonly presence: any
  private readonly onSyncCallback: (players: Player[]) => void

  constructor(presence: any, onSyncCallback: (players: Player[]) => void) {
    this.presence = presence
    this.onSyncCallback = onSyncCallback

    this.presence.onSync(this.onSync)
  }

  private onSync = () => {
    const players = this.presence.list((playerName: string, player: PlayerPresence) => {
      return new Player({name: playerName})
    })

    this.onSyncCallback(players)
  }
}
