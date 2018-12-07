import "phoenix_html";

import * as React from "react";
import * as ReactDOM from "react-dom";
import { Hello } from "./Hello";

if (document.getElementById("game-root")) {
  ReactDOM.render(<Hello compiler="Typescript" framework="React" bundler="Webpack" />,
    document.getElementById("game-root"));
}
