'use strict';

var React = require("react");
var ReactDOMRe = require("reason-react/src/legacy/ReactDOMRe.bs.js");

var container = React.createElement("div", undefined, "Hello World!");

ReactDOMRe.renderToElementWithId(container, "app");

exports.container = container;
/* container Not a pure module */
