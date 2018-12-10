import {Presence} from "phoenix"

// DefinitelyTyped ts definitions are not up to date,
// so we have to leave this as a js file.
export const createPresence = (channel) => {
  return new Presence(channel)
}