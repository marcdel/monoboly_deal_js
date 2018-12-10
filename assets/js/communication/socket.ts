import {Socket} from "phoenix"

const socket: Socket = new Socket("/socket", {
  logger: (kind: string, msg: string, data: object) => {
    // console.log(`${kind}: ${msg}`, data)
  },
  params: {token: (window as any).userToken},
})

export default socket
