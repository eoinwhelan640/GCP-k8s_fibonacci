import React from 'react';
import { Link } from 'react-router-dom';

export default () => {
  return (
    <div>
      The Fibonacci sequence is a series of numbers in \nwhich each number is the sum of the two preceding numbers. \nThe simplest is the series 1, 1, 2, 3, 5, 8, 13...\n 
      <Link to="/">Go back home </Link>
    </div>
  );
};
