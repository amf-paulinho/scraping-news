import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";
import HeadLines from "../components/HeadLines";

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/headlines" exact component={HeadLines} />
    </Switch>
  </Router>
);
