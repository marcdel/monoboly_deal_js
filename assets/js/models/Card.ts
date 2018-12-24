import {Action} from "../models/cards/action"
import {Money} from "../models/cards/Money"
import {DualProperty} from "./cards/DualProperty"
import {Property} from "./cards/Property"
import {WildProperty} from "./cards/WildProperty"
import {Rent} from "./cards/Rent"

export type Card =
  Action |
  DualProperty |
  Money |
  Property |
  WildProperty |
  Rent
