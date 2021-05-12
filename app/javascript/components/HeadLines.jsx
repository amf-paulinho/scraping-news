import React from "react";
import { Link } from "react-router-dom";

class HeadLines extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      headlines: [],
    };
  }

  componentDidMount() {
    const url = "/api/v1/head_lines/index";
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((response) => this.setState({ headlines: response }))
      .catch(() => this.props.history.push("/"));
  }

  render() {
    const { headlines } = this.state;
    const allHeadlines = headlines.map((headline, index) => (
      <div key={index} class="card">
        <div class="card-header">{headline.source}</div>
        <div class="card-body">
          <h5 class="card-title">{headline.title}</h5>

          <a href={headline.link} class="btn btn-primary" target="_blank">
            Read More...
          </a>
        </div>
      </div>
    ));
    const noHeadline = (
      <div class="bg-light p-5 rounded-lg m-3">
        <h1 class="display-4">Hello, there is no headlines yet!</h1>
        <p class="lead">
          You have to execute the scraper script in order to see some headlines
          here.
        </p>
        <hr class="my-4" />
        <p>
          - Open your shell <br />
          - Go to this aplication Root Folder <br />
          - Execute: ./scraper.rb <br />
          - Refresh this page
          <br />
        </p>
        <a class="btn btn-primary btn-lg" href="#" role="button">
          Execute for me !
        </a>
      </div>
    );

    return <div>{headlines.length > 0 ? allHeadlines : noHeadline}</div>;
  }
}

export default HeadLines;
