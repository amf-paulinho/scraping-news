import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">News Scraper</h1>
        <p className="lead">
          In the App Root Folder there is a Ruby Script 'scraper.rb' which is
          scrapping head lines from 2 websites: https://abcnews.go.com and
          https://www.bbc.com. Running the Script will populate the database and
          to see the results click the button bellow.
        </p>
        <hr className="my-4" />
        <Link
          to="/headlines"
          className="btn btn-lg custom-button"
          role="button"
        >
          View Headlines
        </Link>
      </div>
    </div>
  </div>
);
